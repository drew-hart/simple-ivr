## Summary
This application sets up a simple inbound IVR, or phone system. Once setup, you will be able to establish an outside business phone number. Callers will be presented with options when they call to reach various departments or people in your organization (e.g. press 1 for sales or 2 for support. Callers can leave voicemails and those will be emailed to an address within your organization (e.g. a person or a group email inbox).

## Application Setup
Before you get started, you'll need to create a [developer account](http://developers.corvisa.com). You will then need to create new application or use the example application which is created for you when you create a new account on Summit. With the application created, you then clone the repository that's provided to you in the [dashboard](https://platform.corvisacloud.com). You will see the Git URL under Applications > List. With those steps completed, you will want to copy this project's files *excluding the git* folders.

## Setting up Datastore

Summit provides you with powerful database tool, where you can store data. You can access datastore through the Summit Dashboard. To create a Summit account visit [developer website](http://developers.corvisa.com)


### Setting up your tables
Several tables are required for this application to function. You create tables by logging into the dashboard and clicking on Application > Datastore. From there select your application on the drop down and create tables by clicking on the plus sign. Below are a list of tables that are used in this application to get you started, but you are welcome to change them to meet your needs.

### **Note:** The table names used in the screen shots below match those in `main.lua`. If you want to change then, just be sure they match. 
 
### Department Information

 		Name: Department Information
 		Type: Map

 		Key Name:  sales	Key Values: name = [department name]
 							Key Values: phone = [forwarding phone number]
 							Key Values: email = [email to send voicemails]

 		Key Name:  support	Key Values: name = [department name]
 							Key Values: phone = [forwarding phone number]
 							Key Values: email = [email to send voicemails]

![Screenshot - Department Information](https://cloud.githubusercontent.com/assets/2274907/7027352/9d94896c-dd14-11e4-8ce0-e0690cf8b908.png)

### Office hours
 		Name: Office Hours
 		Type: Map

 		Key Name: sunday     Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
 		
 		Key Name: monday     Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
 		
 		Key Name: tuesday    Key Values: name = start, value = [HHMM]
							 Key Values: name = end, value = [HHMM]
		
		... repeat this for each day of the week 

![Screenshot - Office hours](https://cloud.githubusercontent.com/assets/2274907/7027355/a673db3c-dd14-11e4-9f01-a2ce8baa04ec.png) 

### Closed message
 		Name: Office is Closed Message
 		Type: String
 		Key:  message     Value: [the message you want played]

![Screenshot - Closed message](https://cloud.githubusercontent.com/assets/2274907/7027364/ac3ea02e-dd14-11e4-9aa5-0aaa781c6a51.png)

## License
This project is licensed under the terms of the [MIT license](http://opensource.org/licenses/MIT)

## Todo
* add voicemail feature during closed hours
* add optional SMS notification for voicemails
* allow wav or mp3 files for greetings
* add blocked callers feature - custom message and no voicemail
* add priority callers feature - alwasy open
* add unit tests