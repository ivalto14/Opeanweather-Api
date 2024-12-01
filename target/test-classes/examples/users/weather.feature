Feature: Weather API Tests

  Background:
    * url baseUrl
    * def apiKey = karate.get('apiKey') // Obteniendo la clave de la API desde la configuración

  Scenario Outline: Obtener la información del clima consultando por nombre de ciudad
    Given path 'weather'
    And param q = '<city>'
    And param appid = apiKey
    When method GET
    Then status 200
    And match response.name == '<city>'

    Examples:
      | city       |
      | London     |
      | Paris      |
      | Tokyo      |
      | New York   |
      | Sydney     |
      | Bogota     |

  Scenario Outline: Obtener la información del clima consultando por latitud y longitud
    Given path 'weather'
    And param lat = '<lat>'
    And param lon = '<lon>'
    And param appid = apiKey
    When method GET
    Then status 200
    And match response.coord.lat == <lat>
    And match response.coord.lon == <lon>

    Examples:
      | lat | lon |
      | 35 | 139 |
      | -33.86| 151.21|
      | 4.6097 | -74.08|
      | 6.24 | -75.58|
      | 35.68 | 139.69|
      | -34.61| -58.38|

  Scenario: Obtener la información del clima en formato JSON
    Given path 'weather'
    And param q = 'London'
    And param appid = apiKey
    And param mode = 'json'
    When method GET
    Then status 200
    And match response.name == 'London'

  Scenario: Obtener la información del clima en formato XML
    Given path 'weather'
    And param q = 'London'
    And param appid = apiKey
    And param mode = 'xml'
    When method GET
    Then status 200

  Scenario: Obtener información del clima con clave de API inválida
    Given path 'weather'
    And param q = 'London'
    And param appid = 'invalid_api_key'
    When method GET
    Then status 401
    And match response.message == 'Invalid API key. Please see https://openweathermap.org/faq#error401 for more info.'

  Scenario: Obtener información del clima sin clave de API
    Given path 'weather'
    And param q = 'London'
    When method GET
    Then status 401
    And match response.message == 'Invalid API key. Please see https://openweathermap.org/faq#error401 for more info.'

  Scenario: Obtener información del clima sin parámetro de ciudad
    Given path 'weather'
    And param appid = apiKey
    When method GET
    Then status 400
    And match response.message == 'Nothing to geocode'

  Scenario: Obtener información del clima sin parámetro de longitud
    Given path 'weather'
    And param lat = '35'
    And param appid = apiKey
    When method GET
    Then status 400 And match response.message == 'Nothing to geocode'

