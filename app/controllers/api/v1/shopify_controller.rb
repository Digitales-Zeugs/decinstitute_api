require "uri"
require "net/http"

class Api::V1::ShopifyController < ApplicationController

    def index
      @shopify = Shopify.all
      render json: @shopify
    end

    def get_mettl_certifications

      mettlUrl = "https://certification.mettl.com/api/v2/tests"
      ak = "72dd0e43-5372-4c8c-a39b-6ea72a68fd29"
      mettlSubdomain = "dec-institute"
      timestamp = (Time.now.to_i).to_s 
      private_key = "d3ab81bb-a73c-4217-8b68-81e678ac3c02"

      data =  "GET" + mettlUrl + "\n" + ak + "\n" + mettlSubdomain  + "\n" +  timestamp;
    
      signatureCode = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', private_key, data))
      asgn = CGI.escape(signatureCode)

      requestUrl = "https://certification.mettl.com/api/v2/tests?ak=" + ak + "&subdomain=" + mettlSubdomain + "&ts=" + timestamp + "&asgn=" + asgn

      url = URI(requestUrl)


      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = https.request(request)

      render json: response.read_body
    end

    def get_order_info
        puts 'Getting Order Info:'
        data = request.body.read
        json_data = JSON.parse data
        line_items = json_data['line_items']
        #Save useful information
        id = json_data["id"]
        email = json_data["email"]
        nombre = json_data["billing_address"]["first_name"]
        apellido = json_data["billing_address"]["last_name"]
        producto = line_items[0]['title']
        #Aditional data:
        notes = json_data["customer"]["note"]
        datos = notes.split("\n", 6)
        birth = datos[0].split(": ", 2)
        # eachNumber = birth[1].split("-", 3) 
        # dateOfBith = eachNumber[2] + "/" + eachNumber[1] + "/" + eachNumber[0]
        dateOfBirth = birth[1].to_date.strftime("%d/%m/%Y")
        gender = datos[1].split(": ", 2)
        industry = datos[2].split(": ", 2)
        jobtitle = datos[3].split(": ", 2)
        country = datos[4].split(": ", 2)
        levelOfEducation = datos[5].split(": ", 2)
        #Fin debug
        ##DEBUG
        puts '******STEP 1******'
        puts id
        puts email
        puts nombre
        puts apellido
        puts producto
        puts dateOfBirth
        puts gender
        puts industry
        puts jobtitle
        puts country
        puts levelOfEducation
        puts '******'

        rd = generate_rd_string(email, nombre, apellido, dateOfBirth, country, gender, industry, jobtitle, levelOfEducation)
        puts rd.to_s

        $urlCertificate = "https://certification.mettl.com/api/v2/applicants/certificate"
        mettlUrl = "https://certification.mettl.com/api/v2/registerApplicant"
        $ak = "72dd0e43-5372-4c8c-a39b-6ea72a68fd29"
        $mettlSubdomain = "dec-institute"
        $timestamp = (Time.now.to_i).to_s 
        private_key = "d3ab81bb-a73c-4217-8b68-81e678ac3c02"

        data =  "POST" + mettlUrl + "\n" + $ak + "\n" + rd.to_s + "\n" + $mettlSubdomain  + "\n" +  $timestamp;
    
        signatureCode = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', private_key, data))
        asgn = CGI.escape(signatureCode)

        ##DEBUG 3
        puts '******STEP 3******'
        puts $postMethod
        puts mettlUrl
        puts $ak
        puts $mettlSubdomain
        puts $timestamp
        puts private_key
        puts data
        puts asgn
        puts '*****'
        ## END DEBUG 3

        responseJson = createApplicant(mettlUrl, $ak, $mettlSubdomain, $timestamp, rd, asgn)

        #END OF USER REGISTRATION METTL
        dataApplicantJson = JSON.parse responseJson
        #Status Variable - It will define if the register was succesfull or failed
        applicantStatus = dataApplicantJson["status"]

        if applicantStatus == "SUCCESS"
          emailApplicant = dataApplicantJson["applicants"].first['email']
          @shopify = Shopify.create!(:email => email, :first_name => nombre, :last_name => apellido, :birthday => dateOfBirth.to_date, :country => country[1], :gender => gender[1], :industry => industry[1], :job_title => jobtitle[1], :level_of_education => levelOfEducation[1], :status => true, :product => producto, :response => responseJson.to_s)
          puts '******STEP 4******'
          puts dataApplicantJson
          puts applicantStatus
          puts 'Applicant Created with email:'
          puts emailApplicant
          puts '******'
          # if producto.include? "ANALYST"
          #   generateCertificate(emailApplicant, "29213")
          # elsif producto.include? "BLOCKCHAIN"
          #   generateCertificate(emailApplicant, "29212")
          # elsif producto.include? "PRACTICE TEST"
          #   generateCertificate(emailApplicant, "23134")
          # end
          if producto.include? "CHARTERED BLOCKCHAIN ANALYST"
            generateCertificate(emailApplicant, "29212")
          elsif producto.include? "CHARTERED DIGITAL ASSET ANALYST"
            generateCertificate(emailApplicant, "29213")
          elsif producto.include? "PRACTICE TEST"
            if producto.include? "CBA"
              generateCertificate(emailApplicant, "29578")
            elsif producto.include? "CDAA"
              generateCertificate(emailApplicant, "29579")
            end
          end
        elsif applicantStatus == "ERROR"
          puts '******STEP 4******'
          @shopify = Shopify.create!(:email => email, :first_name => nombre, :last_name => apellido, :birthday => dateOfBirth.to_date, :country => country[1], :gender => gender[1], :industry => industry[1], :job_title => jobtitle[1], :level_of_education => levelOfEducation[1], :status => false, :product => producto, :response => responseJson.to_s)
          puts dataApplicantJson
          puts "Register Error, contact with admin"
          puts '*****'
        else
          @shopify = Shopify.create!(:email => email, :first_name => nombre, :last_name => apellido, :birthday => dateOfBirth.to_date, :country => country[1], :gender => gender[1], :industry => industry[1], :job_title => jobtitle[1], :level_of_education => levelOfEducation[1], :status => false, :product => producto, :response => responseJson.to_s)
          puts 'Unknown Error'
        end

        puts responseJson
    
        #timestamp
        render json: 'ok', status: :ok
    end

    def generate_rd_string(email, nombre, apellido, dateOfBirth, country, gender, industry, jobtitle, levelOfEducation)


      step1 = '{"registrationDetails" :[{"Email Address":"'
      step2 = '", "First Name" : "'
      step3 = '", "Last Name" : "'
      step4 = '", "Date of birth": "'
      step5 = '","Country" : "'
      step6 = '", "Gender": "'
      step7 = '", "Industry": "'
      step8 = '","Job Titel": "'
      step9 = '", "Level of Education": "'
      step10 = '", "context_data":"CONTEXT_DATA" }] ,"sendEmail" : true,"isAdminVerified":false}' #mod: sendemail; isadminverified

      # rd = step1 + email + step2 + nombre + step3 + apellido + step4 + dateOfBirth  + step5 + country[1] + step6 + gender[1] + step7 + industry[1] + step8 + "Dr" + step9  + levelOfEducation[1]+ step10
      rd = step1 + email + step2 + nombre + step3 + apellido + step4 + dateOfBirth  + step5 + country[1] + step6 + gender[1] + step7 + "Banking" + step8 + "Dr" + step9  + "Diploma" + step10
  
      return rd

    end

    def createApplicant(url, ak, subdomain, ts, rd, asgn)
    
      url = URI(url)
      
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/x-www-form-urlencoded"
  
      request.body = "ak="+ ak + "&subdomain="+ subdomain + "&ts=" + ts + "&rd=" + rd.to_s + "&asgn=" + asgn
  
      response = https.request(request)
      return response.read_body
    end

    def createCertificate(url, ak, subdomain, ts,atd, asgn)
      
      url = URI(url)
      
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/x-www-form-urlencoded"
  
      request.body = "ak=" + ak + "&subdomain=" + subdomain + "&ts=" + ts + "&atd=" + atd + "&asgn="+ asgn
      
      response = https.request(request)
      puts response.read_body
      
    end 
  
    #method to create the signature and build the atd to add the certificate to the applicant 
  
    def generateCertificate(emailApplicant, testId)
  
      #PROCESS TO GENERATE SIGNATURE (add a certificate to the applicant)
      #Mettl variables 
      #Example atd = '{"applicants" : [{"email" : "gaby@yopmail.com" ,"tests" : {"add": [ { "testId" : 23022}] }}]}'
      #Building atd:
        applicantsStr = '{"applicants":[{"email":"'
        testsStr = '","tests":{"add":[{"testId":' 
        finalStr = '}]}}]}'
        atd = applicantsStr + emailApplicant + testsStr + testId + finalStr
      # Finish building atd
  
        private_key = "d3ab81bb-a73c-4217-8b68-81e678ac3c02"
          
        data =  "POST" + $urlCertificate + "\n" + $ak + "\n" + atd + "\n" + $mettlSubdomain  + "\n" +  $timestamp ;
  
        #Creating signature 
        signatureCode = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', private_key, data))
  
         asgn = CGI.escape(signatureCode)
  
         #ADDING A CERTIFICATE TO THE USER CREATED IN METTL
         createCertificate($urlCertificate, $ak, $mettlSubdomain, $timestamp, atd, asgn )
    end
  

end
