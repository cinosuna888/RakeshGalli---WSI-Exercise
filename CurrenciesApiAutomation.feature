Feature: Using Karate framework of my choice for API automation
  
  1. Use technology of your choice for automation
  2. Outcome should be a report with list of test cases and automation test results.
  3. URL Structure: https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@{apiVersion}/{date}/{endpoint}
  a. Formats: date - The date should either be latest or in YYYY-MM-DD format
  	 Note: Historical rates before 2020-11-22 are not available
  b. The Endpoints Supports HTTP GET Method and returns the data in two formats: i. /{endpoint}.json
  4. Endpoints: /currencies

  @allcurrencies
  Scenario: Lists all the available currencies in prettified json format
    Given url 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json'
    When method get
    Then status 200
    * print response
    * match response.ada == 'Cardano'

  @EurBase
  Scenario: Get the currency list with EUR as base currency
    Given url 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/eur.json'
    When method get
    Then status 200
    * print response
    * match response.eur.usd contains 1.135712

  @EURtoJPY
  Scenario: Get the currency value for EUR to JPY
    Given url 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/eur/jpy.json'
    When method get
    Then status 200
    * print response
    * match response ==
      """
      {
      "date": "2022-02-16",
      "jpy": 131.344789
      }
      """

  @EURtoXYZ
  Scenario: Get the currency value for EUR to XYZ
    Given url 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/eur/xyz.json'
    When method get
    Then status 403
    * print response

  @EURtoUSD
  Scenario: Get the currency value for EUR to USD
    Given url 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/eur/usd.json'
    When method get
    Then status 200
    * print response
    * match response ==
      """
      {
      "date": "2022-02-16",
      "usd": 1.135712
      }
      """
