require "uri"
require "net/http"

class Api::V1::InvoicesController < ApplicationController
  def create_invoice
    puts "aa"
    request.body.rewind
    data = request.body.read

    puts "DATA"
    # puts data

    #Parse data as jSON
    json_data = JSON.parse data

    line_items = json_data["line_items"]

    puts line_items

    #User Info
    userId = json_data["id"]
    $userEmail = json_data["email"]
    $userFirstName = json_data["billing_address"]["first_name"]
    $userLastName = json_data["billing_address"]["last_name"]
    $userAddress = json_data["billing_address"]["address1"]
    $userZipCode = json_data["billing_address"]["zip"]
    $userCity = json_data["billing_address"]["city"]
    userCountry = json_data["billing_address"]["country"]
    #Product:
    $productName = json_data["line_items"][0]["title"]
    puts $productName
    $productPrice = json_data["line_items"][0]["price"].to_i
    $productValue = json_data["line_items"][0]["price"].to_s

    #Discount:
    $productDiscount = json_data["total_discounts"].to_i

    #finding discount
    # $productPrice = '100'
    # $productValue = '30'
    # $productDiscount = '0'

    var1 = $productDiscount.to_f
    var2 = $productPrice.to_f
    cuenta = var1 / var2
    var3 = (cuenta * 100).round(2)
    $percentageDiscount = var3.to_s

    # $percentageDiscount = '30'
    #end

    $productQty = json_data["line_items"][0]["quantity"].to_s
    cantidad = line_items[0]["quantity"].to_s
    # dataNotes = json_data["customer"]["note"]

    if json_data["customer"]["note"]
      userNotes = json_data["customer"]["note"].split("\n", 5)
      $userGender = userNotes[1].split(": ", 2)
    else
      userNotes = ""
      $userGender = ""
    end

    # userNotes = ""
    # $userGender = ""

    puts $userGender

    $listOfContactsStr = getListOfContacts

    if $productName != "PRACTICE TEST FOR CBX® AND CDAAA®"
      if $productName != "MOCKUP TEST FOR CBX® AND CDAA®"
        if $percentageDiscount != "100"
          if $productValue != "0"
            if $listOfContactsStr.include? $userEmail
              puts "THE CONTACT ALREADY EXIST"
              arrayContacts = JSON.parse $listOfContactsStr
              arrayContacts.each do |elemento|
                if $userEmail == elemento["mail"]
                  user_id = elemento["user_id"].to_s
                  owner_id = elemento["id"].to_s

                  idInvoice = createBexioInvoice(user_id, owner_id)
                  invoiceDraftToPending(idInvoice)
                  #Code for user invoices
                end
              end
            else
              puts "THE CONTACT DOES NOT EXIST"
              user = createBexioUser
              contact = createContact(user)
              idInvoice = createBexioInvoice(user, contact)
              invoiceDraftToPending(idInvoice)
            end
          end
        end
      end
    end

    render json: "Hola", status: :ok
  end

  def getListOfContacts
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

  def createBexioInvoice(userId, contactId)
    url = URI("https://api.bexio.com/2.0/kb_invoice")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = "application/json"
    request[
      "Authorization"
    ] = "Bearer eyJraWQiOiI2ZGM2YmJlOC1iMjZjLTExZTgtOGUwZC0wMjQyYWMxMTAwMDIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcm5vLnBlcm50aGFsZXJAZGVjaW5zdGl0dXRlLm9yZyIsImxvZ2luX2lkIjoiZmM2OTVlZDktMTZhZS00MGJkLWE0M2QtOGRiYzMzYmRiOWMzIiwiY29tcGFueV9pZCI6ImtlaXV6MHkxa2JkOSIsInVzZXJfaWQiOjI2ODUwNiwiYXpwIjoiZXZlcmxhc3QtdG9rZW4tb2ZmaWNlLWNsaWVudCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgYWxsIHRlY2huaWNhbCIsImlzcyI6Imh0dHBzOlwvXC9pZHAuYmV4aW8uY29tIiwiZXhwIjozMTkyMjcxNTIyLCJpYXQiOjE2MTU0NzE1MjIsImNvbXBhbnlfdXNlcl9pZCI6MSwianRpIjoiOTA3MzdmZTEtNjhlMy00Y2Y5LWJkODgtZDgyZWYzMjE4M2JmIn0.EX_WUzl0ysbwP869XaxOO3G7JWuEM2MB0rXP4XDU2cFL4-ne3pyL5V-GGn6C8GbiGEru4C4V8Ov8jSzCV68poxDhCLLlOvDqB3umqfsWlympuSHJ42z2G0MG0WFxUvz-9oQ9FZcyHQVkhgDmyWhyZ7oeXgZYlf9rxtWjFiP_cphTEmCyHPqXJ6jajTuJaKe915IZjMli6potKp-A1xe9mUagcAdi5D5UUq-NgFT95dDGeNu6ty_nymEHPkrQ4LayR5mKz3t0AMQKKAQyRg8ZzgUX4sLQbOCAAtTLi4exKwjOYU7wLtug1J9crLDc1wOCwZ3yayQeAzeEdUc5KC4Lq9bsC4CbhQQX_be__8-MbF9X9-FpS20nmbUTn5wQE7_TsXJJfy-iGfgaWpAPVYE3z7bt_RGpwpWgjBG-v3vCvr8bfNT0Y5bnehdQpNRDQ5F_ZMzNOh6cS8t_Usgm9oynbjKHdVrGIoZ70JYnZmHL0AiqF1Jz2vB7Hrarr-QWTpPhKC7_zE9QSbm4lTMyk8nKhkBmpID0QAkWRJYdqR0UGLD4FkUMNIPVHEuGuqFM83_2PG_YtkJHkZSNjCQIrAEEqGB86R_QxxFAc9xGuUfZn0cC7Rh1Vulk3LLroKkzo0FNCLF7K9q3QwhS7DKB-ihG0YZr4RmRirdpHqHVONwBLP4"
    request["Content-Type"] = "application/json"

    request.body =
      '{"currency_id": ' + '"2"' + ', "user_id": "' + userId +
        '", "contact_id": "' + contactId + '", "title": "' + $productName +
        '", "positions": [{ "type":  "KbPositionCustom", "amount": "' +
        $productQty + '", "unit_price": "' + $productValue + '", "tax_id":  ' +
        '"3"' + '  , "text": "' + $productName +
        '" , "discount_in_percent": "' + $percentageDiscount + '" }] }'

    #currency_id 2 = EUR
    #currency_id default 1 = CHF

    bexioResponse = https.request(request)
    puts "INVOICE CREATED"
    bexioResponseData = JSON.parse(bexioResponse.read_body)
    puts 'INVOICE:'
    puts bexioResponseData
    return bexioResponseData["id"].to_s
  end

  def createBexioUser
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

    request.body =
      '{ "salutation_type": "Mr.", "firstname": "' +
        $userFirstName + '", "lastname": "' + $userLastName +
        '", "email": "' + $userEmail.downcase + '" }'

    response = https.request(request)
    #puts response.read_body

    #Assign id of user

    dataOne = response.read_body

    responseData = JSON.parse dataOne

    #Assign id of user from response
    puts "USER CREATED:"
    puts responseData["id"]
    return responseData["id"].to_s
  end

  def createContact(user_id)
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

    puts user_id

    request.body =
      '{"mail": "' + $userEmail.downcase + '", "city": "' + $userCity +
        '", "postcode": "' + $userCity + '", "address": "' + $userAddress +
        '", "user_id": "' + user_id + '", "owner_id": "' + user_id +
        '" ,"name_1": "' + $userLastName + '", "name_2": "' +
        $userFirstName + '", "contact_type_id": ' + '"2"' + " }"

    response = https.request(request)
    ##puts response.read_body
    #Buscamos ID contact

    dataTwo = response.read_body
    dataID = JSON.parse dataTwo

    #Assign id of contact from response
    puts "CONTACT CREATED ID"
    puts dataID["id"]
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
