<h1><img src="./photo/mstock_logo.svg"></h1>

 <img src="https://img.shields.io/badge/SpringMVC-5.0.2.RELEASE-brightgreen.svg">

## What is this?

> Stock-Learing Platform For Stock Beginners

### Function

- Real-time stock information parsing and Stock Chart implementation
- Stock Purchase/Sales and History Functions
- Analysis through real-time news data collection and pretreatment
  - Sensitivity Analysis, Regression Analysis, and WordCloud Using R

- Knowledge sharing function (board, chat)
- Real-time ranking



## Stack

> Front-end

- HTML5 / CSS3 / JavaScript / jQuery / Ajax
- Bootstrap
- Chart.js

> Back-end

- Spring STS 3.9.9
- Tomcat v9.0 
- JAVA (jdk1.8.0_211)
- Mybatis
- R, Rserve
- JSP
- Oracle Database Express Edition 11g Release 2



## Installation

1. https://github.com/kyun9/MStock  - ["Clone or download" Click]
2. Import from Eclipse



## Usage

1. Oracle database CREATE user and GRANT

   ```sql
   create user {mstock} identified by {mstock};
   grant connect, resource to {mstock};
   ```

2. Import 'mstock.dmp'

   ```bash
   $ imp userid={userid}/{password}@SID file='{filename}.dmp' 
   ```

3. Add configure.properties

   ```properties
   #Add  '/src/main/resources/config/configure.properties'
   
   #Database Information
   username={mstock}
   password={mstock}
   dburl= jdbc:oracle:thin:@{URL}:1521:XE
   
   #Naver login API Info
   naver.client_id={Naver_Client_Id}
   naver.client_secret={Naver_Client_Secret}
   naver.callback_url={Naver_Callback_URL}
   
   #R file path
   rsource.newsUpload='{Folder_location}/Rsource/newsupload.R', encoding = 'UTF-8'
   rsource.allAnalysis='{Folder_location}/Rsource/All_Analysis.R', encoding = 'UTF-8'
   ```

4. Run the Rserve (at the installation location)

   ```bash
   $ Rserve --RS-encoding utf8
   ```

5. [Add server from Tomcat v9.0 in Eclipse] - [Start the server]



## Screenshots

<img src="./photo/main.png">
