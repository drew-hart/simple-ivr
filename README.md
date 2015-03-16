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

![Screenshot - Group numbers](https://cloud.githubusercontent.com/assets/2274907/6675784/1154702c-cbf1-11e4-9e25-0513865a3935.png)

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
