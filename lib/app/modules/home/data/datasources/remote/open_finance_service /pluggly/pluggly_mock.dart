

var mock_itemid = {
  "id": "a5d1ca6c-24c0-41c7-8b44-9272cc868663",
  "createdAt": "2021-12-28T21:48:02.863Z",
  "updatedAt": "2021-12-28T21:48:02.952Z",
  "connector": {
    "id": 201,
    "name": "Itaú",
    "primaryColor": "EC7000",
    "institutionUrl": "https://www.itau.com.br",
    "country": "BR",
    "type": "PERSONAL_BANK",
    "credentials": [
      {
        "label": "Agência",
        "name": "agency",
        "type": "number",
        "placeholder": "Agência",
        "validation": "^\\d{4}",
        "validationMessage": "O agencia deve ter 4 dígito"
      },
      {
        "label": "Conta",
        "name": "account",
        "type": "number",
        "placeholder": "Conta",
        "validation": "^\\d{4,6}",
        "validationMessage": "O conta deve ter 6 dígito"
      },
      {
        "label": "Senha",
        "name": "password",
        "type": "number",
        "placeholder": "Senha",
        "validation": "^\\d{6}",
        "validationMessage": "O senha deve ter 6 dígito"
      }
    ],
    "imageUrl": "https://res.cloudinary.com/dkr0vihmp/image/upload/v1588853552/connectors-logos/itau_ntodvn.png",
    "hasMFA": false,
    "products": [
      "ACCOUNTS",
      "TRANSACTIONS",
      "CREDIT_CARDS",
      "INVESTMENTS",
      "IDENTITY",
      "PAYMENT_DATA"
    ],
    "oauthUrl": "https://example-oauth-url.com"
  },
  "status": "UPDATING",
  "executionStatus": "CREATED",
  "lastUpdatedAt": null,
  "webhookUrl": null,
  "error": null,
  "clientUserId": "My User App Id",
  "parameter": null,
  "userAction": null,
  "statusDetail": {
    "accounts": {
      "isUpdated": true,
      "lastUpdatedAt": "2022-03-08T22:43:04.796Z",
      "warnings": []
    },
    "identity": {
      "isUpdated": false,
      "lastUpdatedAt": null,
      "warnings": []
    },
    "creditCards": {
      "isUpdated": true,
      "lastUpdatedAt": "2022-03-08T22:43:04.796Z",
      "warnings": []
    },
    "investments": {
      "isUpdated": true,
      "lastUpdatedAt": "2022-03-08T22:43:04.796Z",
      "warnings": [
        {
          "code": "001",
          "message": "You lack permissions to view Investments on this account",
          "providerMessage": "Meu perfil não permite visualizar investimentos"
        }
      ]
    },
    "transactions": {
      "isUpdated": true,
      "lastUpdatedAt": "2022-03-08T22:43:04.796Z",
      "warnings": []
    },
    "paymentData": null
  },
  "nextAutoSyncAt": null,
  "consecutiveFailedLoginAttempts": 0
};

var mock_account = {
  "page": 1,
  "total": 2,
  "totalPages": 1,
  "results": [
    {
      "id": "a658c848-e475-457b-8565-d1fffba127c4",
      "type": "BANK",
      "subtype": "CHECKING_ACCOUNT",
      "number": "0001/12345-0",
      "name": "Conta Corrente",
      "marketingName": "GOLD Conta Corrente",
      "balance": 15000,
      "itemId": "a0922d6f-2007-4169-a181-b961500608db",
      "taxNumber": "416.799.495-00",
      "owner": "John Doe",
      "currencyCode": "BRL",
      "bankData": {
        "transferNumber": "0001/12345-0",
        "closingBalance": 120950
      }
    },
    {
      "id": "a658c848-e475-457b-8565-d1fffba127c4",
      "type": "CREDIT",
      "subtype": "CREDIT_CARD",
      "number": "xxxx8670",
      "name": "Mastercard Black",
      "marketingName": "PLUGGY UNICLASS MASTERCARD BLACK",
      "balance": 120950,
      "itemId": "a0922d6f-2007-4169-a181-b961500608db",
      "taxNumber": "416.799.495-00",
      "owner": "John Doe",
      "currencyCode": "BRL",
      "creditData": {
        "level": "BLACK",
        "brand": "MASTERCARD",
        "balanceCloseDate": "2022-01-03",
        "balanceDueDate": "2022-01-03",
        "availableCreditLimit": 200000,
        "balanceForeignCurrency": 0,
        "minimumPayment": 16190,
        "creditLimit": 300000
      }
    }
  ]
};

var mock_transactions = {
  "total": 8,
  "totalPages": 1,
  "page": 1,
  "results": [
    {
      "id": "a8534c85-53ce-4f21-94d7-50e9d2ee4957",
      "description": "* PROV * COMPRA TESOURO DIRETO CLIENTES",
      "descriptionRaw": "* PROV * COMPRA TESOURO DIRETO CLIENTES",
      "currencyCode": "BRL",
      "amount": -212.45,
      "date": "2020-10-15T00:00:00.000Z",
      "balance": 4439.4,
      "category": "Fixed Income Investment",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "DEBIT"
    },
    {
      "id": "05c693bf-c196-47ea-a28c-8251d6bb8a06",
      "description": "PAGO NETFLIX SERV",
      "descriptionRaw": "PAGO NETFLIX SERV",
      "currencyCode": "BRL",
      "amount": -298.19,
      "date": "2020-10-15T00:00:00.000Z",
      "balance": 4651.85,
      "category": "Video streaming",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "DEBIT",
      "merchant": {
        "name": "Netflix",
        "businessName": "NETFLIX ENTRETENIMENTO BRASIL LTDA.",
        "cnpj": "00000000000000",
        "category": "Video streaming",
        "cnae": "5911100"
      }
    },
    {
      "id": "97536285-cc22-4a5a-9d05-f5fe24410d0c",
      "description": "* PROV * DEVOLUÇÃO DE MARGEM",
      "descriptionRaw": "* PROV * DEVOLUÇÃO DE MARGEM",
      "currencyCode": "BRL",
      "amount": 2482.26,
      "date": "2020-10-15T00:00:00.000Z",
      "balance": 4950.04,
      "category": "Margin Withdrawn",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "CREDIT"
    },
    {
      "id": "8caf328b-4528-4de6-b931-10639d0084c5",
      "description": "LIQUIDO DAS OPERAÇÕES BMF PR. 14/10/2020 NC. 870947",
      "descriptionRaw": "LIQUIDO DAS OPERAÇÕES BMF PR. 14/10/2020 NC. 870947",
      "currencyCode": "BRL",
      "amount": -1.06,
      "date": "2020-10-14T00:00:00.000Z",
      "balance": 2467.78,
      "category": "Investment",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "DEBIT"
    },
    {
      "id": "ff9ed929-edc4-408c-a959-d51f79ab1814",
      "description": "AJUSTE NA POSIÇÃO PR. 14/10/2020 NC. 870947",
      "descriptionRaw": "AJUSTE NA POSIÇÃO PR. 14/10/2020 NC. 870947",
      "currencyCode": "BRL",
      "amount": 159.2,
      "date": "2020-10-14T00:00:00.000Z",
      "balance": 2468.84,
      "category": "Investment",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "CREDIT"
    },
    {
      "id": "093fc873-442a-4bd8-9171-51f17892fb09",
      "description": "LIQUIDO DAS OPERAÇÕES BM&F PR. 14/10/2020 NC. 870947",
      "descriptionRaw": "LIQUIDO DAS OPERAÇÕES BM&F PR. 14/10/2020 NC. 870947",
      "currencyCode": "BRL",
      "amount": -10.3,
      "date": "2020-10-14T00:00:00.000Z",
      "balance": 2309.64,
      "category": "Investment",
      "accountId": "562b795d-1653-429f-be86-74ead9502813",
      "providerCode": null,
      "status": "POSTED",
      "paymentData": null,
      "type": "DEBIT"
    },
    {
      "id": "6ec156fe-e8ac-4d9a-a4b3-7770529ab01c",
      "description": "TED Example",
      "descriptionRaw": null,
      "currencyCode": "BRL",
      "amount": 1500,
      "date": "2020-10-14T00:00:00.000Z",
      "balance": 3500,
      "category": "Transfer",
      "accountId": "03cc0eff-4ec5-495c-adb3-1ef9611624fc",
      "providerCode": "123456",
      "type": "CREDIT",
      "status": "POSTED",
      "paymentData": {
        "payer": {
          "name": "Tiago Rodrigues Santos",
          "branchNumber": "090",
          "accountNumber": "1234-5",
          "routingNumber": "001",
          "documentNumber": {
            "type": "CPF",
            "value": "882.937.076-23"
          }
        },
        "reason": "Taxa de serviço",
        "receiver": {
          "name": "Pluggy",
          "branchNumber": "999",
          "accountNumber": "9876-1",
          "routingNumber": "002",
          "documentNumber": {
            "type": "CNPJ",
            "value": "08.050.608/0001-32"
          }
        },
        "paymentMethod": "TED",
        "referenceNumber": "123456789"
      }
    }
  ]
};