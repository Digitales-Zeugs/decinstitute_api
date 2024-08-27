require "uri"
require "net/http"

class Api::V1::InvoicesController < ApplicationController

  def create_invoice

    # Para todas las invoice el contact tiene que ser ARNO -> Buscar contactID y asignarlo
    # Contact ID 3

    request.body.rewind
    data = request.body.read

    puts "*** DEBUG: RAW DATA ***"
    puts data
    # data = '{"id":5135027830933,"admin_graphql_api_id":"gid:\/\/shopify\/Order\/5135027830933","app_id":580111,"browser_ip":"157.143.20.183","buyer_accepts_marketing":true,"cancel_reason":null,"cancelled_at":null,"cart_token":"c1-db6c8549b1f6f4d663b4aedd64957d62","checkout_id":35138388099221,"checkout_token":"ee4a396a7d07c5ebabfdd206a2315cc7","client_details":{"accept_language":"en-CH","browser_height":null,"browser_ip":"157.143.20.183","browser_width":null,"session_hash":null,"user_agent":"Mozilla\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\/537.36 (KHTML, like Gecko) Chrome\/116.0.0.0 Safari\/537.36"},"closed_at":"2023-09-29T15:56:42+02:00","confirmation_number":"AG1IHF2PG","confirmed":true,"contact_email":"urs.bolt@bolt-now.com","created_at":"2023-09-03T16:19:35+02:00","currency":"EUR","current_subtotal_price":"437.00","current_subtotal_price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"current_total_additional_fees_set":null,"current_total_discounts":"0.00","current_total_discounts_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"current_total_duties_set":null,"current_total_price":"437.00","current_total_price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"current_total_tax":"0.00","current_total_tax_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"customer_locale":"en-CH","device_id":null,"discount_codes":[],"email":"urs.bolt@bolt-now.com","estimated_taxes":false,"financial_status":"paid","fulfillment_status":"fulfilled","landing_site":"\/","landing_site_ref":null,"location_id":null,"merchant_of_record_app_id":null,"name":"#2672","note":null,"note_attributes":[],"number":1672,"order_number":2672,"order_status_url":"https:\/\/shop.decinstitute.org\/52111343765\/orders\/02b769cfd15f9e7e3502f4a32c6bf65a\/authenticate?key=a503b25b7bc2b49b3f9c5a334772be80","original_total_additional_fees_set":null,"original_total_duties_set":null,"payment_gateway_names":["stripe"],"phone":null,"po_number":null,"presentment_currency":"EUR","processed_at":"2023-09-03T16:19:30+02:00","reference":"a937ed12937e9b57eeb39e663cf9afc5","referring_site":"https:\/\/www.decinstitute.org\/","source_identifier":"a937ed12937e9b57eeb39e663cf9afc5","source_name":"web","source_url":null,"subtotal_price":"437.00","subtotal_price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"tags":"","tax_exempt":false,"tax_lines":[],"taxes_included":true,"test":false,"token":"02b769cfd15f9e7e3502f4a32c6bf65a","total_discounts":"0.00","total_discounts_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"total_line_items_price":"437.00","total_line_items_price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"total_outstanding":"0.00","total_price":"437.00","total_price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"total_shipping_price_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"total_tax":"0.00","total_tax_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"total_tip_received":"0.00","total_weight":0,"updated_at":"2023-09-29T15:56:42+02:00","user_id":null,"billing_address":{"first_name":"Urs","address1":"Dufaux-Strasse 60","phone":null,"city":"Glattpark (Opfikon)","zip":"8152","province":null,"country":"Switzerland","last_name":"Bolt","address2":null,"company":null,"latitude":47.4204303,"longitude":8.561999799999999,"name":"Urs Bolt","country_code":"CH","province_code":null},"customer":{"id":6837241315477,"email":"urs.bolt@bolt-now.com","accepts_marketing":true,"created_at":"2023-06-04T14:40:36+02:00","updated_at":"2023-09-03T16:27:01+02:00","first_name":"Urs","last_name":"Bolt","state":"enabled","note":null,"verified_email":true,"multipass_identifier":null,"tax_exempt":false,"phone":null,"email_marketing_consent":{"state":"subscribed","opt_in_level":"single_opt_in","consent_updated_at":"2023-08-29T19:02:06+02:00"},"sms_marketing_consent":null,"tags":"","currency":"EUR","accepts_marketing_updated_at":"2023-08-29T19:02:06+02:00","marketing_opt_in_level":"single_opt_in","tax_exemptions":[],"admin_graphql_api_id":"gid:\/\/shopify\/Customer\/6837241315477","default_address":{"id":8151279337621,"customer_id":6837241315477,"first_name":"Urs","last_name":"Bolt","company":null,"address1":"Dufaux-Strasse 60","address2":null,"city":"Glattpark (Opfikon)","province":null,"country":"Switzerland","zip":"8152","phone":null,"name":"Urs Bolt","province_code":null,"country_code":"CH","country_name":"Switzerland","default":true}},"discount_applications":[],"fulfillments":[{"id":4632599167125,"admin_graphql_api_id":"gid:\/\/shopify\/Fulfillment\/4632599167125","created_at":"2023-09-29T15:56:41+02:00","location_id":58638336149,"name":"#2672.1","order_id":5135027830933,"origin_address":{},"receipt":{},"service":"manual","shipment_status":null,"status":"success","tracking_company":null,"tracking_number":null,"tracking_numbers":[],"tracking_url":null,"tracking_urls":[],"updated_at":"2023-09-29T15:56:41+02:00","line_items":[{"id":12575010291861,"admin_graphql_api_id":"gid:\/\/shopify\/LineItem\/12575010291861","fulfillable_quantity":0,"fulfillment_service":"manual","fulfillment_status":"fulfilled","gift_card":false,"grams":0,"name":"CDAA® PRACTICE TEST - LEVEL 1","price":"0.00","price_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"product_exists":true,"product_id":7839814287509,"properties":[],"quantity":1,"requires_shipping":false,"sku":"","taxable":false,"title":"CDAA® PRACTICE TEST - LEVEL 1","total_discount":"0.00","total_discount_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"variant_id":43251835076757,"variant_inventory_management":"shopify","variant_title":null,"vendor":"DEC Institute","tax_lines":[],"duties":[],"discount_allocations":[]},{"id":12575010324629,"admin_graphql_api_id":"gid:\/\/shopify\/LineItem\/12575010324629","fulfillable_quantity":0,"fulfillment_service":"manual","fulfillment_status":"fulfilled","gift_card":false,"grams":0,"name":"CHARTERED DIGITAL ASSET ANALYST (CDAA)® - LEVEL 1","price":"437.00","price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"product_exists":true,"product_id":6354933710997,"properties":[],"quantity":1,"requires_shipping":false,"sku":"","taxable":false,"title":"CHARTERED DIGITAL ASSET ANALYST (CDAA)® - LEVEL 1","total_discount":"0.00","total_discount_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"variant_id":37839027241109,"variant_inventory_management":"shopify","variant_title":null,"vendor":"DEC Institute","tax_lines":[],"duties":[],"discount_allocations":[]}]}],"line_items":[{"id":12575010291861,"admin_graphql_api_id":"gid:\/\/shopify\/LineItem\/12575010291861","fulfillable_quantity":0,"fulfillment_service":"manual","fulfillment_status":"fulfilled","gift_card":false,"grams":0,"name":"CDAA® PRACTICE TEST - LEVEL 1","price":"0.00","price_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"product_exists":true,"product_id":7839814287509,"properties":[],"quantity":1,"requires_shipping":false,"sku":"","taxable":false,"title":"CDAA® PRACTICE TEST - LEVEL 1","total_discount":"0.00","total_discount_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"variant_id":43251835076757,"variant_inventory_management":"shopify","variant_title":null,"vendor":"DEC Institute","tax_lines":[],"duties":[],"discount_allocations":[]},{"id":12575010324629,"admin_graphql_api_id":"gid:\/\/shopify\/LineItem\/12575010324629","fulfillable_quantity":0,"fulfillment_service":"manual","fulfillment_status":"fulfilled","gift_card":false,"grams":0,"name":"CHARTERED DIGITAL ASSET ANALYST (CDAA)® - LEVEL 1","price":"437.00","price_set":{"shop_money":{"amount":"437.00","currency_code":"EUR"},"presentment_money":{"amount":"437.00","currency_code":"EUR"}},"product_exists":true,"product_id":6354933710997,"properties":[],"quantity":1,"requires_shipping":false,"sku":"","taxable":false,"title":"CHARTERED DIGITAL ASSET ANALYST (CDAA)® - LEVEL 1","total_discount":"0.00","total_discount_set":{"shop_money":{"amount":"0.00","currency_code":"EUR"},"presentment_money":{"amount":"0.00","currency_code":"EUR"}},"variant_id":37839027241109,"variant_inventory_management":"shopify","variant_title":null,"vendor":"DEC Institute","tax_lines":[],"duties":[],"discount_allocations":[]}],"payment_terms":null,"refunds":[],"shipping_address":null,"shipping_lines":[]}'
    puts "*** END DEBUG: RAW DATA ***"

    #Parse data as jSON
    json_data = JSON.parse data

    line_items = json_data["line_items"]

    #User Info
    userId = json_data["id"]
    $userEmail = json_data["email"]
    $userFirstName = json_data["billing_address"]["first_name"]
    $userLastName = json_data["billing_address"]["last_name"]
    $userAddress = json_data["billing_address"]["address1"]
    $userZipCode = json_data["billing_address"]["zip"]
    $userCity = json_data["billing_address"]["city"]
    $userCountry = json_data["billing_address"]["country"]
    $userCountryCode = json_data["billing_address"]["country_code"]

    countryCodes = {
      'CH' => 1, 'DE' => 2, 'AT' => 3, 'BR' => 4, 'CA' => 5,
      'CN' => 6, 'CZ' => 7, 'FR' => 8, 'GB' => 9, 'IT' => 10,
      'LI' => 11, 'HK' => 12, 'PT' => 13, 'EG' => 14, 'US' => 15,
      'ES' => 16, 'AU' => 17, 'AR' => 18, 'MV' => 19, 'BG' => 20,
      'RO' => 21, 'LU' => 22, 'TR' => 23, 'IL' => 24, 'NL' => 25,
      'AE' => 26, 'BE' => 27, 'SG' => 28, 'ME' => 29, 'QA' => 30,
      'DK' => 31, 'SE' => 32, 'MY' => 33, 'IE' => 34, 'NO' => 35,
      'FI' => 36, 'HU' => 37, 'MX' => 38, 'RS' => 39
    }

    $userCountryId = countryCodes[$userCountryCode]

    puts 'COUNTRY ID: ', $userCountryId

    products = []

    json_data["line_items"].each do |prod|
      product_name = prod["title"]
      product_price = prod["price"].to_i
      product_value = prod["price"].to_s
      product_discount = 0
      prod["discount_allocations"].each do |discount|
        product_discount = discount["amount"].to_f
      end

      # puts ">>>>>>>>>A<<<<<<<<<<"
      # puts product_price, product_value, product_discount
      # puts ">>>>>>>>>B<<<<<<<<<<"

      if product_price != 0
        percentage_discount = (((product_discount / product_price) * 100).round(2)).to_s
      else
        percentage_discount = '0'
      end

      product_qty = prod["quantity"].to_s

      product_line = { 
        "type": "KbPositionCustom", 
        "amount": product_qty,
        "unit_price": product_value, 
        "tax_id": "3", 
        "text": product_name, 
        "discount_in_percent": percentage_discount
      }

      if percentage_discount != "100" && product_value != "0"
        products.push(product_line)
      end

    end

    if json_data["customer"]["note"]
      userNotes = json_data["customer"]["note"].split("\n", 5)
      $userGender = userNotes[1].split(": ", 2)
    else
      userNotes = ""
      $userGender = ""
    end

    $listOfContactsStr = getListOfContacts()

    if $productName != "PRACTICE TEST FOR CBX® AND CDAAA®"
      if $productName != "MOCKUP TEST FOR CBX® AND CDAA®"
        if $percentageDiscount != "100"
          if $productValue != "0"
            if $listOfContactsStr.include? $userEmail.downcase
              puts "Contact already exists. Asigning new invoice."
              arrayContacts = JSON.parse $listOfContactsStr
              # TEST
              # search_contact($userEmail)
              # END TEST

              # FIXME: Errores
              arrayContacts.each do |elemento|
                if $userEmail == elemento["mail"]
                  user_id = elemento["user_id"].to_s
                  owner_id = elemento["id"].to_s

                  idInvoice = createBexioInvoice(user_id, owner_id, products)
                  invoiceDraftToPending(idInvoice)
                  #Code for user invoices
                end
              end
              # END FIXME

            else
              puts "Contact does not exist. Creating a new one."
              # user = createBexioUser()
              # contact = createContact(user)
              contact = createContact()
              idInvoice = createBexioInvoice(1, contact, products)
              invoiceDraftToPending(idInvoice)
            end
          end
        end
      end
    end

    render json: "Invoice Created", status: :ok
  end

  def search_contact(email)
    puts "Searching contact with email: ", email
    url = URI("https://api.bexio.com/2.0/contact/search")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"
    
    request.body = JSON.dump({
      "field": "mail",
      "value": email
      # "criteria": "="
    })

    response = https.request(request)

    puts "RESPONSE FROM SEARCH", response.read_body


  end

  def getListOfContacts()
    url = URI("https://api.bexio.com/2.0/contact")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"

    response = https.request(request)

    return response.read_body
  end

  def createBexioInvoice(userId, contactId, products)
    url = URI("https://api.bexio.com/2.0/kb_invoice")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"

    puts "UID ", userId, contactId

    request.body = JSON.dump({
      "currency_id": 2,
      # User ID: 1 Corresponds to Arno Pernthaler
      "user_id": 1,
      "contact_id": contactId,
      "title": 'DEC Invoice',
      "positions": products
    })

    #currency_id 2 = EUR
    #currency_id default 1 = CHF

    bexioResponse = https.request(request)
    puts "INVOICE CREATED"
    bexioResponseData = JSON.parse(bexioResponse.read_body)
    puts 'Data:'
    puts bexioResponseData
    return bexioResponseData["id"].to_s
  end

  def createBexioUser()
    #Code for user register
    url = URI("https://api.bexio.com/3.0/fictional_users")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"

    request.body = JSON.dump({
      "salutation_type": "male",
      "firstname": $userFirstName,
      "lastname": $userLastName,
      "email": $userEmail.downcase
    })

    response = https.request(request)

    puts response.read_body

    #Assign id of user
    dataOne = response.read_body

    responseData = JSON.parse dataOne

    #Assign id of user from response
    puts "USER CREATED:"
    puts responseData["id"]
    return responseData["id"].to_s
  end

  def createContact()
    #Code for user contacts

    url = URI("https://api.bexio.com/2.0/contact")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"

    # request.body =
    #   '{"mail": "' + $userEmail.downcase + '", "city": "' + $userCity +
    #     '", "postcode": "' + $userZipCode + '", "address": "' + $userAddress + '"country": 1' +
    #     '", "user_id": "1", "owner_id": "1" ,"name_1": "' + $userLastName + '", "name_2": "' +
    #     $userFirstName + '", "contact_type_id": ' + '"2"' + " }"

    request.body = {
      "name_1": $userLastName,
      "name_2": $userFirstName,
      "address": $userAddress,
      "postcode": $userZipCode,
      "city": $userCity,
      "country_id": 1,
      "mail": $userEmail.downcase,
      "contact_type_id": 2,
      "user_id": 1,
      "owner_id": 1
  }.to_json

    response = https.request(request)
    
    puts 'Contact Created -> RES: ', response.read_body

    dataTwo = response.read_body
    dataID = JSON.parse dataTwo

    return dataID["id"].to_s
  end

  def invoiceDraftToPending(id_invoice)
    concatenatedUrl =
      "https://api.bexio.com/2.0/kb_invoice/" + id_invoice + "/issue"
    url = URI(concatenatedUrl)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"

    response = https.request(request)
    puts response.read_body
  end
end
