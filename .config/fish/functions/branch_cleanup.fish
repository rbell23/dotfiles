function branch_cleanup
    set -l dry_run 0
    set -l excluded main
    for arg in $argv
        if test "$arg" = --dry-run
            set dry_run 1
        else
            set excluded $excluded $arg
        end
    end
    set -l current_branch (git branch --show-current)
    if test -n "$current_branch"
        set excluded $excluded $current_branch
    end
    for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
        if not contains -- "$branch" $excluded
            if test $dry_run -eq 1
                echo "Would delete: $branch"
            else
                git branch -D $branch
            end
        end
    end
end
