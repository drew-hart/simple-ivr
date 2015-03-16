# Setting up Datastore

Summit provides you with powerful database tool, where you can
store data. You can access datastore through the Summit Dashboard. 
To create a Summit account visit [developer website](http://developers.corvisa.com)


## Setting up your tables
Several tables are required for this application to function. You
create tables by logging into the dashboard and clicking on 
Application > Datastore. From there select your application on the 
drop down and create tables by clicking on the plus sign. Below are
a list of tables that are used in this application to get you
started, but you are welcome to change them to meet your needs.
 
## Group numbers

 		Name: Group Numbers
 		Type: String
 		Key:  sales      Value: [your phone number]
 		Key:  support    Value: [a phone number]
 		![alt tag](https://d1zjcuqflbd5k.cloudfront.net/files/acc_6099/1jUj1?response-content-disposition=inline;%20filename=Screen%20Shot%20on%202015-03-16%20at%2015%3A09%3A05.png&Expires=1426536626&Signature=RTTx-gxazxOGW5oZ3GyzVXo21t7VJnEoXWFUB-mO3Pe~QiyS8pdAVY0l3DhLl4bCXtCbD1H4MpRfeMN7aEWf66Y7-YuorJs4Zr7eNgoDS9MQdsLB-yBPmYwBhyMP-DkiIF2Zc4lMaJNiKO8YSNuDLvrgQS3g0rYMZ4twCu0KwK4_&Key-Pair-Id=APKAJTEIOJM3LSMN33SA)

## Office hours
 		Name: Office Hours
 		Type: Map
 		Key Name: sunday     Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
 		Key Name: monday     Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
 		Key Name: tuesday    Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
		... repeat this for each day of the week 
 

## Closed message
 		Name: Office is Closed Message
 		Type: String
 		Key:  message     Value: [the message you want played]
