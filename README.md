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

![Screenshot - Group numbers](https://cloud.githubusercontent.com/assets/2274907/6675843/8345beac-cbf1-11e4-9d59-7dfda9e0b60a.png)

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

![Screenshot - Office hours](https://cloud.githubusercontent.com/assets/2274907/6675876/cd11b0cc-cbf1-11e4-8514-d2806518b0c1.png) 

## Closed message
 		Name: Office is Closed Message
 		Type: String
 		Key:  message     Value: [the message you want played]

![Screenshot - Closed message](https://cloud.githubusercontent.com/assets/2274907/6675925/2c8578ae-cbf2-11e4-996c-638574c78e16.png)