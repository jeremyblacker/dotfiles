# -D "<DOMAIN>\jblacker" -W
# ldapsearch -LLL -x -h madc01 -b "ou=<Enterprise Name> Groups,dc=<domain>,dc=com" "member= CN=Jeremy Blacker,OU=<City>,OU=Accounts,DC=<domain>,DC=com" cn mail

alias lookup-commands="grep -A 2 lookup /Users/jblacker/.bashrc | grep -v alias"

function lookupAD {
    ldapsearch -LLL -x -h madc01 -b "ou=Accounts,dc=<domain>,dc=com" "sAMAccountName=$1" name department sAMAccountName mail manager dn whenCreated whenChanged title description directreports badPasswordTime badPwdCount
}

function lookupGroupMembership {
    ldapsearch -LLL -x -h madc01 -b "ou=<Enterprise Name> Groups,dc=<domain>,dc=com" "cn=$1" dn member
    ldapsearch -LLL -x -h madc01 -b "ou=Okta Groups,dc=<domain>,dc=com" "cn=$1" dn member
}


function lookupMailList {
    ldapsearch -LLL -x -h madc01 -b "ou=<Enterprise Name> Groups,dc=<domain>,dc=com" "mail=$1" dn member
    ldapsearch -LLL -x -h madc01 -b "ou=Okta Groups,dc=<domain>,dc=com" "mail=$1" dn member
}

function lookupOkta {
    DN=$(ldapsearch -LLL -x -h madc01 -b "ou=Accounts,dc=<domain>,dc=com" "sAMAccountName=$1" dn)
    ldapsearch -LLL -x -h madc01 -b "ou=Okta Groups,dc=<domain>,dc=com" "member= $(echo $DN | awk '{print $2" "$3" "$4" "$5}')" cn mail
}

function lookupADgroup {
    DN=$(ldapsearch -LLL -x -h madc01 -b "ou=Accounts,dc=<domain>,dc=com" "sAMAccountName=$1" dn)
    ldapsearch -LLL -x -h madc01 -b "ou=<Enterprise Name> Groups,dc=<domain>,dc=com" "member= $(echo $DN | awk '{print $2" "$3" "$4" "$5}')" cn mail
}

function lookupLDAP {
    ldapsearch -LLL -x -h office-inf101  -b "ou=People,dc=<domain>,dc=com" "uid=$1"
}

function myAD {
    ldapsearch -LLL -x -h madc01 -b "ou=Accounts,dc=<domain>,dc=com" "sAMAccountName=jblacker" name department sAMAccountName mail manager dn whenCreated whenChanged title description badPwdCount badPasswordTime lastLogoff lastLogon pwdLastSet logonCount lastLogonTimestamp
}

function LDAP-group-membership {
    ldapsearch -LLL -x -h office-inf101  -b "ou=Group,dc=<domain>,dc=com" "memberUid=$1" cn 
}
