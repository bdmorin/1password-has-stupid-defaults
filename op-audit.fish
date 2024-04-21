#!/usr/bin/env fish

set --global CACHE '--cache'
echo "# gathering users"
set --global op_user_list (op $CACHE user list | awk '{print $1}' | tail -n +2)
echo "# gathering groups"
set --global op_group_list (op $CACHE  group list | awk '{print $1}' | tail -n +2)
echo "# gathering vaults"
set --global op_vault_list (op $CACHE vault list | awk '{print $1}' | tail -n +2)

for vault in $op_vault_list
    echo "op vault group list $vault --format json | gron"
end


# This process is really slow, so run the output through parellel
# fish op-gen-ids.fish > revoke.cmd
# parallel -j 8 < revoke.cmd 
# or whatever suits you.