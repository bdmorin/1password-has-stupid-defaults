#!/usr/bin/env fish

echo "# gathering users"
set --global op_user_list (op user list | awk '{print $1}' | tail -n +2)
echo "# gathering groups"
set --global op_group_list (op group list | awk '{print $1}' | tail -n +2)
echo "# gathering vaults"
set --global op_vault_list (op vault list | awk '{print $1}' | tail -n +2)

for vault in $op_vault_list
    echo "# processing $vault"
    for user in $op_user_list
        echo "# processing $user in $vault"
        echo op vault user revoke --vault $vault --user $user --permissions export_items,print_items
    end
    for group in $op_group_list
        echo "# processing $group in $vault"
        echo op vault group revoke --vault $vault --group $group --permissions export_items,print_items
    end
end

# This process is really slow, so run the output through parellel
# fish op-gen-ids.fish > revoke.cmd
# parallel -j 8 < revoke.cmd 
# or whatever suits you.