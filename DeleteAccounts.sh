#!/bin/bash
# A simple script to delete accounts in Cloud Conformity

echo "Which region is your conformity environment hosted in?"
read -r region

echo "Enter your api key: "
read -r apikey


# get list of accounts in Conformity 

export accountIds=(`curl -L -X GET \
        "https://$region-api.cloudconformity.com/v1/accounts" \
        -H "Content-Type: application/vnd.api+json" \
        -H "Authorization: ApiKey $apikey" \
        | jq -r '.data | map(.id) | join(",")'`)
        
echo "List of accounts in Conformity $accountIds";

# delete accounts in Conformity
 for i in $(echo $accountIds | sed "s/,/ /g")
do
curl -X DELETE "https://$region-api.cloudconformity.com/v1/accounts/$i" \
     -H "Content-Type: application/vnd.api+json" \
     -H "Authorization: ApiKey $apikey"
done
      echo "These are all the accounts deleted successfully $i"
