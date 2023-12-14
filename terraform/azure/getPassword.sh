az webapp deployment list-publishing-credentials --name appServiceSDV1 --resource-group fromTerra1 | grep \"publishingPassword\" | python3 parseCredential.py
