# Notes

## About parsing arguments in Bash:
You should also consider the error supression and error handling features of getopts.

If the very first character of the option string is a colon (:) then getopts will not report errors and instead will provide a means of handling the errors yourself. Two additional characters can then be used within your case conditional handling:

    ? If an invalid option is entered then $opt will be set to ? and $OPTARG will hold the invalid character, e.g. if -z was used, which is not in your option string, then $OPTARG will be set to z.

    : If a required additional argument is omitted by the user then $opt will be set to : and $OPTARG will hold the command character, e.g. if -p was used instead of -p arg then $OPTARG will be set to p.

If this is implemented then the catch-all of * becomes redundant and should be removed. Note: If you leave it in and it is above either ? or : then you'll be asking for problems. Also make sure the ? is escaped like this \?).

Hope this helps.

*Note the addition of the inital colon before 'f'.*

```bash
while getopts :f:d:c:p: opt;
do
    case $opt in
        d)  display_help=$OPTARG
            ;;
        f)  file_arg=$OPTARG
            ;;
        c)  column=$OPTARG
            ;;
        p)  pattern=$OPTARG
            ;;

        # Option error handling.

        \?) valid=0
            echo "An invalid option has been entered: $OPTARG"
            ;;

        :)  valid=0
            echo "The additional argument for option $OPTARG was omitted."
            ;;

        # This is now redundant:
        # *)  valid=0
        #     break
        #     ;;
    esac
done
```

[Original Stack Overflow answer](https://stackoverflow.com/a/24868071/6842897)