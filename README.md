<h1><img src="./photo/mstock_logo.svg"></h1>

 <img src="https://img.shields.io/badge/SpringMVC-5.0.2.RELEASE-brightgreen.svg"><img src="https://img.shields.io/badge/Contributors-4-yellow.svg">

## What is this?

> Stock-Learing Platform For Stock Beginners

### Function

- Real-time stock information parsing and Stock Chart implementation
- Stock Purchase/Sales and History Functions
- Analysis through real-time news data collection and pretreatment
  - Sentiment Analysis, Regression Analysis, and WordCloud Using R
- Knowledge sharing function (board, chatting)
- Real-time ranking



## Stack

> Front-end

- HTML5 / CSS3 / JavaScript / jQuery / Ajax
- Bootstrap
- Chart.js
- WebSocket

> Back-end

- Spring STS 3.9.9
- Tomcat v9.0 
- JAVA (jdk1.8.0_211)
- Mybatis
- R-3.6.1, Rserve
- JSP
- Oracle Database Express Edition 11g Release 2



## Installation

1. https://github.com/kyun9/MStock.git  - [Clone or download]
2. Import into Eclipse



## Usage

1. Oracle database CREATE USER and GRANT

   ```sql
   CREATE USER {userid} IDENTIFIED BY {password};
   GRANT CONNECT, RESOURCE TO {userid};
   ```

2. Import 'mstock.dmp'

   ```bash
   $ imp userid={userid}/{password}@SID file='mstock.dmp' 
   ```

3. Add configure.properties

   ```properties
   #Add  '/src/main/resources/config/configure.properties'
   
   #Database Information
   username={userid}
   password={password}
   dburl= jdbc:oracle:thin:@{URL}:1521:XE
   
   #Naver login API Information
   naver.client_id={Naver_Client_Id}
   naver.client_secret={Naver_Client_Secret}
   naver.callback_url={Naver_Callback_URL}
   
   #R file path
   rsource.newsUpload='{Folder_location}/Rsource/newsupload.R', encoding = 'UTF-8'
   rsource.allAnalysis='{Folder_location}/Rsource/All_Analysis.R', encoding = 'UTF-8'
   ```

4. Install the library related to the R source

5. Run the Rserve (at the installation location)

   ```bash
   $ Rserve --RS-encoding utf8
   ```

6. [Add server from Tomcat v9.0 in Eclipse] - [Start the server]



## Screenshots

<img src="./photo/main.png">
