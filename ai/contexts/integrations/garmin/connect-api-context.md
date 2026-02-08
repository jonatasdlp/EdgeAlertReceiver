### Install Connect IQ SDK Manager

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started

Instructions for downloading and setting up the Connect IQ SDK Manager on Windows, Linux, and Mac. This tool manages SDK and device updates.

```text
1. Go to developer.garmin.com/connect-iq/sdk
2. In the **Install the SDK Manager** section select _Accept & Download_
3. Create a new folder in a convenient location
    1. **Windows and Linux** - Copy the executable and support files to the new folder1
    2. **Mac** - Open the disk image and copy the SDK manager to the new folder
  4. Launch the SDK Manager.
```

--------------------------------

### Install Monkey C VS Code Extension

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started

Guide to installing the Monkey C extension for Visual Studio Code, which provides syntax highlighting, build integration, and debugging for Connect IQ development.

```text
1. In Visual Studio Code, go to the _View_ > _Extension_
2. In the Extensions Marketplace, search box type "Monkey C"
3. Select the _Monkey C_ extension from Garmin
4. Use the _Install_ button to install the extension in Visual Studio Code. This will require a restart of Visual Studio Code.
5. After Visual Studio Code restarts, summon the command palette with _Ctrl + Shift + P_ (_Command + Shift + P_ on Mac)
6. Type "Verify Installation" and select _Monkey C: Verify Installation_
```

--------------------------------

### Configure SDK Manager Credentials and Updates

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started

Steps to log in to the SDK Manager using Connect account credentials and configure automatic updates for SDKs and devices.

```text
5. Press the **Login** button and enter the credentials of the Connect account:
6. The SDK Manager can remember your credentials or you can re-enter them every time. Select which option you prefer and press **Next**
7. You'll be presented with the option of having the Connect IQ SDK update automatically, or to be notified when a new version is available. Select the option you prefer and press **Next**
8. You'll be presented with the option of having Connect IQ devices update, or to be notified when new devices are available. If you want to update devices automatically, you can choose the types of devices you want updates for. Select the option you prefer and press **Finish**
```

--------------------------------

### Garmin Connect IQ SDK Setup

Source: https://developer.garmin.com/connect-iq/device-reference/fr945lte

Instructions on how to get the Connect IQ SDK, which is essential for developing applications for Garmin devices. This typically involves downloading and installing the SDK package.

```bash
# Example command to download the SDK (actual URL would be provided on Garmin's site)
# curl -O https://developer.garmin.com/connect-iq/sdk/connectiq-sdk-mac-x64-4.x.x.dmg
#
# After downloading, follow the installation instructions provided by Garmin.
```

--------------------------------

### Configure Monkey C Developer Key Path

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started

How to set the path to your developer key within the Monkey C extension settings in Visual Studio Code, enabling the compiler to use your key for signing.

```text
If you have a developer key, you can set the path to it by selecting _File > Preferences > Settings > Monkey C_ and setting the _Monkey C: Developer Key Path_ to your developer key.
```

--------------------------------

### Android: Open Connect IQ Store Page

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-use-the-connect-iq-mobile-sdk

This Java code demonstrates how to open the Connect IQ store page for your application on Android. This is used to guide users to install your Connect IQ app from the store.

```Java
Intent intent = new Intent("com.garmin.connectiq.action.OPEN_STORE");
intent.putExtra("appId", "your_app_id");
startActivity(intent);
```

--------------------------------

### Generate Developer Key with Monkey C Extension

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started

Instructions on how to generate a RSA 4096 bit private developer key using the Monkey C extension in Visual Studio Code, required for app signing.

```text
1. Summon the command palette with _Ctrl + Shift + P_ (_Command + Shift + P_ on Mac)
2. Type "Generate a developer key" and select _Monkey C: Generate a Developer Key_
3. Select the directory in which to save your developer key
```

--------------------------------

### App Lifecycle Example - Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

Demonstrates the basic app lifecycle by overriding methods of the AppBase class. This example shows how to initialize the AppBase class, handle application start and stop events, and return the initial view.

```Monkey C
using Toybox.Application;
class AppLifeCycle extends Application.AppBase {
    // initialize the AppBase class
    function initialize() {
        AppBase.initialize();
    }
    // onStart() is called on application start up
    function onStart(state) {
    }
    // onStop() is called when your application is exiting
    function onStop(state) {
    }
    // Return the initial view of your application here
    function getInitialView() {
        return [new AppLifeCycleView()];
    }
}
```

--------------------------------

### Start Playback (Monkey C)

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-create-an-audio-content-provider

This example shows how to initiate audio playback using the Media.startPlayback() method within a Connect IQ app, allowing users to play downloaded content.

```Monkey C
function startAudioPlayback(contentId) {
    // Start playback of the selected audio content
    Media.startPlayback(contentId);
}
```

--------------------------------

### Connect IQ SDK Setup and Basic Monkey C

Source: https://developer.garmin.com/connect-iq/device-reference/edge1030bontrager

This snippet outlines the initial steps for setting up the Connect IQ SDK and provides a basic example of Monkey C code, the primary language for developing Connect IQ apps. It covers essential syntax and structure for creating watch faces or applications.

```Monkey C
using Toybox.WatchUi;

class HelloWorldView extends Ui.View {

    function onLayout(dc) {
        var view = View.find("id_hello_world");
        view.setText("Hello, Connect IQ!");
        return dc.loadResource(Rez.Layouts.MainLayout(dc));
    }

    function onUpdate(dc) {
        // Update the view
    }

}

class HelloWorldDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }

    function onSelect() {
        // Handle select event
        return true;
    }

}

```

--------------------------------

### iOS: Open Connect IQ Store Page

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-use-the-connect-iq-mobile-sdk

This Objective-C code shows how to open the Connect IQ store page for a specific app within Garmin Connect Mobile. This is useful for prompting users to install your Connect IQ app if it's not already present.

```Objective-C
[[UIApplication sharedApplication] delegate].window.rootViewController.showConnectIQStoreForApp:@"your_app_id"];
```

--------------------------------

### Button Hint Example in Connect IQ

Source: https://developer.garmin.com/connect-iq/user-experience-guidelines/views

This snippet demonstrates how to display a button hint to guide user interaction when there isn't enough visual space for both information and navigation actions.

```Monkey C
function showButtonHint() {
    var hint = new$.ButtonHint({ :label => "Select", :icon => Rez.Drawables.select_button });
    hint.draw();
}
```

--------------------------------

### Handle App Installation

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

The onAppInstall() method is a callback triggered in the background when the application is installed. It requires the Background permission to be enabled and the application class to have the :background annotation.

```Monkey C
function onAppInstall() as Void {
    // App installed in background
}
```

--------------------------------

### Monkey C System.println Example

Source: https://developer.garmin.com/connect-iq/monkey-c

This example shows how to print a message to the debug console using the System.println function in Monkey C.

```Monkey C
System.println( "Hello Monkey C!" );
```

--------------------------------

### AppBase: Get Initial View

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

Specifies the initial View and optional Input Delegate for the application when it starts.

```Monkey C
getInitialView();
```

--------------------------------

### Device Qualifier Example

Source: https://developer.garmin.com/connect-iq/core-topics/build-configuration

This example demonstrates how to use a device qualifier to segregate resources specifically for a particular device model. Resources in this folder will override default resources when building for the specified device.

```Monkey C
resources-fenix5
```

--------------------------------

### OAuth1 Signed Request with Java

Source: https://developer.garmin.com/connect-iq/core-topics/trial-apps

Example of making an OAuth1-signed HTTP GET request to the callbackUrl using the Signpost library and Apache HttpClient in Java. This demonstrates how to sign the request with user credentials and execute it.

```Java
HttpGet request = new HttpGet("callbackUrl");

OAuthConsumer consumer = new CommonsHttpOAuthConsumer("yourKey", "yourSecret");
consumer.sign(request);

HttpClient client = HttpClientBuilder.create().build();
HttpResponse response = client.execute(request);

System.out.println("Return code: " + org.springframework.http.HttpStatus.valueOf(response.getStatusLine().getStatusCode()));
```

--------------------------------

### Initiate Web Request with makeWebRequest

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Communications

This example demonstrates how to use the makeWebRequest function to send a GET request to a specified URL. It includes a callback function to handle the server's response, checking for a successful status code (200) and printing appropriate messages.

```Monkey C
using Toybox.System;
using Toybox.Communications;

// set up the response callback function
function onReceive(responseCode, data) {
    if (responseCode == 200) {
        System.println("Request Successful");                   // print success
    }
    else {
        System.println("Response: " + responseCode);            // print response code
    };

};

function makeRequest() {
    var url = "https://www.garmin.com";                         // set the url

    Communications.makeWebRequest(url, null, {}, method(:onReceive));
}
```

--------------------------------

### Get Bearing from Start (Connect IQ)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity/Info

Retrieves the bearing from the starting location to the destination in radians. This value is dependent on the initial course setup and not on subsequent movements during an activity. Available since API Level 2.1.0.

```Connect IQ
var bearingFromStart as Lang.Float or Null
```

--------------------------------

### AppBase: On App Install

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

Callback method triggered in the background when the application is installed.

```Monkey C
onAppInstall();
```

--------------------------------

### App Store Unlock URL Example

Source: https://developer.garmin.com/connect-iq/core-topics/trial-apps

This example demonstrates the format of a URL that the app store will call to initiate the app unlock process. It includes parameters like `appUnlockRequestId`, `callbackUrl`, and `appPageUrl`, which are essential for the developer's server-side unlock logic.

```URL
https://your.unlock.url.com?appUnlockRequestId=1fe443e5-e76c-4e1c-b82b-2d084bd4c4fe&callbackUrl=https%3A%2F%2Fapps.garmin.com%2FappUnlock%3FappUnlockRequestId%3D1fe443e5-e76c-4e1c-b82b-2d084bd4c4fe&appPageUrl=https%3A%2F%2Fapps.garmin.com%2Fen-US%2Fapps%2Fbf1d944a-8a54-41fa-b7b0-24e651dc88e1
```

--------------------------------

### Import Connect IQ Sample App

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app

Guide on how to import an existing Connect IQ sample application into an IDE. This involves using the 'File > Open Folder...' menu option to navigate to and select the root directory of the downloaded SDK samples.

```Monkey C
// IDE Menu: File > Open Folder...
// Browse to: [SDK Path]/samples/[Sample Name]
// Select Folder
```

--------------------------------

### Starting the Command Line Debugger (mdd)

Source: https://developer.garmin.com/connect-iq/core-topics/debugging

Initiate the Monkey C command line debugger (mdd) to load executables, set breakpoints, and examine program state. Ensure the simulator is running before starting mdd.

```Shell
> simulator &
[1] 27984
> mdd
```

--------------------------------

### Input Delegate Implementation Example

Source: https://developer.garmin.com/connect-iq/personality-library

This snippet provides an example of an Input Delegate implementation for handling user input in a Garmin Connect IQ app. It belongs in your input handler implementation file.

```Monkey C
using Toybox.WatchUi;

class MyInputDelegate extends InputDelegate {

    function initialize() {
        InputDelegate.initialize();
    }

    function onSelect() {
        System.println("Select button pressed!");
        return true;
    }

    function onBack() {
        System.println("Back button pressed!");
        return true;
    }

}
```

--------------------------------

### Initialize and Use BikeSpeed - Connect IQ

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/AntPlus/BikeSpeed

Demonstrates how to initialize an AntPlus.BikeSpeed object with a listener and retrieve speed information. This example shows the basic setup for using the BikeSpeed class to get data from a bike speed sensor.

```Monkey C
using Toybox.AntPlus;

// Assuming Valid BikeSpeedListener object "MyBikeSpeedListener"

// Initialize the AntPlus.BikeSpeedListener object
listener = new MyBikeSpeedListener();

// Initialize the AntPlus.BikeSpeed object with a listener
bikeSpeed = new AntPlus.BikeSpeed(listener);

var speedInfo = bikeSpeed.getSpeedInfo();

// ...etc
```

--------------------------------

### Basic Build and Run Cycle

Source: https://developer.garmin.com/connect-iq/reference-guides/monkey-c-command-line-setup

Illustrates a typical command-line workflow for developing Connect IQ apps: launching the simulator, compiling the code, and running the compiled app.

```bash
// Launch the simulator:
> connectiq

// Compile the executable:
> monkeyc -d fenix5plus -f /path/to/monkey.jungle -o project_name.prg -y /path/to/Dev_Key

// Run in the simulator
> monkeydo myApp.prg fenix5plus
```

--------------------------------

### Handle GCM Installation Requirement

Source: https://developer.garmin.com/connect-iq/core-topics/mobile-sdk-for-ios

Implements the needsToInstallConnectMobile method of the IQUIOverrideDelegate protocol. This method is called when an action requires Connect Mobile (GCM) to be installed. It should inform the user and provide an option to open the App Store for GCM installation.

```Objective-C
- (void)needsToInstallConnectMobile {
    // Show alert to user with choice to install GCM
    if (alert.result == YES) {
       [[ConnectIQ sharedInstance] showAppStoreForConnectMobile];
    }
}
```

--------------------------------

### Install Monkey C VS Code Extension

Source: https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension

Steps to install the Monkey C extension in Visual Studio Code. This involves searching for the extension in the marketplace, installing it, and verifying the installation via the command palette.

```Shell
Ctrl + Shift + P (or Command + Shift + P on Mac)
Monkey C: Verify Installation
```

--------------------------------

### Start Activity Recording in Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/ActivityRecording/Session

Initiates the recording of a FIT file on the system. Returns true if the recording was started successfully, and false otherwise.

```Monkey C
function start() as Lang.Boolean
```

--------------------------------

### Implement SyncDelegate (Monkey C)

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-create-an-audio-content-provider

This code illustrates the implementation of a SyncDelegate for handling synchronization events in a Connect IQ audio content provider app. It includes methods for starting, stopping, and managing sync progress.

```Monkey C
class MySyncDelegate extends WatchUi.SyncDelegate {

    function initialize() {
        SyncDelegate.initialize();
    }

    function onStart(syncInfo) {
        // Sync has started
        System.println("Sync started");
        
        // Download songs chosen in the sync configuration step
        downloadSelectedSongs(syncInfo.selectedContent);
        
        // Notify the system of the sync progress
        notifySyncProgress(0);
        
        return true; // Indicate that the sync is handled
    }

    function onStop(syncInfo) {
        // Sync has stopped
        System.println("Sync stopped");
        return true;
    }

    function onSyncNeeded() {
        // Determine if a sync is needed
        return true;
    }

    function downloadSelectedSongs(selectedContent) {
        // Logic to download selected songs from CDN
        System.println("Downloading selected songs...");
    }

    function notifySyncProgress(progress) {
        // Logic to notify the system of sync progress
        System.println("Sync progress: " + progress + "%");
    }
}
```

--------------------------------

### Get Start Time (Connect IQ)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity/Info

Retrieves the starting time of the current activity. This property is available since API Level 1.0.0.

```Connect IQ
var startTime as Time.Moment or Null
```

--------------------------------

### Implement Media Content Delegate

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-create-an-audio-content-provider

Defines a `Media.ContentDelegate` class to manage media playback. This delegate is responsible for providing a `Media.ContentIterator` which iterates through `Media.ContentRef` instances representing downloaded songs and offers playback customization via `Media.PlaybackProfile`.

```Monkey C
class MyContentDelegate extends Media.ContentDelegate {

    function initialize() {
        Media.ContentDelegate.initialize();
    }

    function getContentIterator(
        args as Dictionary
    ) as Media.ContentIterator or Null {
        // Return an iterator for media content
        return new MyContentIterator();
    }

    function onPlaybackEvent(event as Media.PlaybackEvent) {
        // Handle playback events for reporting
        System.println("Playback event: " + event.name);
    }

}
```

--------------------------------

### AppBase: On Start

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

Method called at application startup to handle initialization tasks. Receives optional state information.

```Monkey C
onStart(state);
```

--------------------------------

### Start FIT Recording

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/ActivityRecording/Session

This method begins recording a FIT file on the system. It returns true if the recording was successfully started, and false otherwise.

```Monkey C
var success = session.start();
```

--------------------------------

### Get Installed Courses Iterator

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves an iterator for all courses that have been saved to the device's persistent storage. This allows for iterating through the installed courses.

```Monkey C
using Toybox.PersistedContent;

var iterator = PersistedContent.getCourses(); // Get the Iterator
```

--------------------------------

### Get Playback Start Position from Toybox.Media.Content

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Media/Content

Retrieves the playback start position for media content. This is useful for resuming playback from a specific point in the media.

```gdev
function getPlaybackStartPosition() as Lang.Number
```

--------------------------------

### Build App with Jungle Files via Command Line

Source: https://developer.garmin.com/connect-iq/reference-guides/jungle-reference

This command demonstrates how to build a Connect IQ application using the `monkeyc` compiler, specifying output, target device, and multiple Jungle files for configuration. The `-f` option accepts a list of Jungle files separated by semicolons or colons.

```bash
monkeyc -o myApp.prg myApp.mc -d fenix5 -f monkey.jungle;monkey2.jungle
```

--------------------------------

### Monkey C App Entry Point Example

Source: https://developer.garmin.com/connect-iq/core-topics/manifest-and-permissions

Demonstrates how to return a view and delegate from the getInitialView() method in a Connect IQ application. This is the standard way to provide the initial user interface and interaction handling for your app.

```Monkey C
return [ new MyView(), new MyDelegate() ];
```

--------------------------------

### Get Start Location (Connect IQ)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity/Info

Retrieves the starting location of the current activity. This member returns a null value unless the Positioning Permission is enabled. Available since API Level 1.0.0.

```Connect IQ
var startLocation as Position.Location or Null
```

--------------------------------

### System.isAppInstalled() - Check App Installation

Source: https://developer.garmin.com/connect-iq/core-topics/application-and-system-modules

Queries the system to determine if a specific application is installed on the device. This is useful for checking dependencies or offering alternative functionality.

```Monkey C
if (System.isAppInstalled("com.garmin.application.anotherAppId")) {
    // App is installed
}
```

--------------------------------

### Get Playback Start Position - Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Media/ActiveContent

Retrieves the playback start position for the media content. This method returns the position as a Lang.Number representing seconds.

```Monkey C
function getPlaybackStartPosition() as Lang.Number {
    // Returns the playback start position
}
```

--------------------------------

### Get Start of Day Time (Connect IQ)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/ActivityMonitor/History

Retrieves a Moment object representing the start time of the day recorded by this History object. This property is of type Time.Moment and is available from API Level 1.0.0.

```Connect IQ
var startOfDay as Time.Moment or Null
// A Moment object representing the start time of the day recorded by this History object
```

--------------------------------

### Initialize ProgressBar

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/ProgressBar

Constructs a new ProgressBar instance. It accepts a display string and an optional starting value. The starting value can be a float between 0 and 100, or null to indicate a busy state.

```Monkey C
function initialize(displayString as Lang.String, startValue as Lang.Float or Null)
// Constructor
// Parameters:
//   displayString — (Lang.String) — The string to display on the ProgressBar
//   startValue — (Lang.Float) — The initial value for the ProgressBar: An increment from 0 to 100 or null for "busy"
// Since: API Level 1.0.0
```

--------------------------------

### Connect IQ Project Structure

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app

Explains the standard directory structure for a Connect IQ project. Includes descriptions for the 'bin' directory (binary and debug output), 'resources' directory (layouts, images, fonts, strings), 'source' directory (Monkey C source files), and 'manifest.xml' (app properties).

```XML
<?xml version="1.0" encoding="utf-8"?>
<manifest>
    <application id="...">
        <property id="...">
        ...
    </application>
</manifest>
```

--------------------------------

### Start a Repeating Timer in Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Timer/Timer

This example demonstrates how to create and start a repeating timer that increments a counter every second. It utilizes the Timer.Timer class and a callback function to update the counter and request a UI update.

```Monkey C
using Toybox.Timer;
var myCount =  0;

function timerCallback() {
    myCount += 1;
    Ui.requestUpdate();
}

function onLayout(dc) {
    var myTimer = new Timer.Timer();
    myTimer.start(method(:timerCallback), 1000, true);
}
```

--------------------------------

### Register Temporal Event Example - Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Background

An example demonstrating how to register a new temporal background event as soon as allowed, using getLastTemporalEventTime() to calculate the next available time slot.

```Monkey C
using Toybox.Background;
using Toybox.Time;
const FIVE_MINUTES = new Time.Duration(5 * 60);
var lastTime = Background.getLastTemporalEventTime();
if (lastTime != null) {
    // Events scheduled for a time in the past trigger immediately
    var nextTime = lastTime.add(FIVE_MINUTES);
    Background.registerForTemporalEvent(nextTime);
} else {
    Background.registerForTemporalEvent(Time.now());
}
```

--------------------------------

### Get Connect IQ App Info and Status

Source: https://developer.garmin.com/connect-iq/core-topics/mobile-sdk-for-android

Retrieves information about a Connect IQ application installed on a device. It checks if the app is installed and if an upgrade is needed by comparing version numbers. Requires an IQApp object and an IQApplicationInfoListener.

```Java
connectIQ.getApplicationInfo(MY_APPLICATION_ID, device, new IQApplicationInfoListener() {
    @Override
    public void onApplicationInfoReceived( IQApp app ) {
        if (app != null) {
            if (app.getStatus() == INSTALLED) {
                if (app.getVersion() < MY_CURRENT_VERSION) {
                    // Prompt the user to upgrade
                }
            }
        }
    }
    @Override
    public void onAPplicationNotInstalled( String applicationId ) {
        // Prompt user with information
        AlertDialog.Builder dialog = new AlertDialog.Builder( this );
        dialog.setTitle( "Missing Application" );
        dialog.setMessage( "Corresponding IQ application not installed" );
        dialog.setPositiveButton( android.R.string.ok, null ); dialog.create().show();
    }
});
```

--------------------------------

### Garmin Connect IQ Settings Menu Example

Source: https://developer.garmin.com/connect-iq/user-experience-guidelines/menus

Illustrates how to create a settings menu in Garmin Connect IQ, typically accessed from a base page, enabling users to customize global application settings. Headers and footers provide context.

```Monkey C
function createSettingsMenu() {
    var menu = Ui.loadResource(Rez.Menus.SettingsMenu);
    var controller = Rez.Menus.MenuController.new(menu);
    return controller;
}
```

--------------------------------

### Check App Installation Status (Monkey C)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/System

Checks if an app is installed on the device. This function takes a URI string (either manifest-id or store-id) and returns a boolean indicating installation status.

```Monkey C
using Toybox.System;
var isInstalled = System.isAppInstalled("manifest-id://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx");
```

--------------------------------

### Install Monkey C Extension in VS Code

Source: https://developer.garmin.com/connect-iq/sdk

This snippet details the process of installing the Monkey C extension within Visual Studio Code to enable development for Garmin Connect IQ devices. It involves searching for the extension in the marketplace and verifying the installation.

```English
1. In Visual Studio Code, go to the _View_ > _Extension_ menu
2. In the Extensions Marketplace, search box type "Monkey C"
3. Select the _Monkey C_ extension from Garmin.
4. Use the _Install_ button to install the extension in Visual Studio Code. This will require a restart of Visual Studio Code.
5. After Visual Studio Code restarts, summon the command palette with _Ctrl + Shift + P_ (_Command + Shift + P_ on Mac).
6. Type "Verify Installation" and select _Monkey C: Verify Installation_
```

--------------------------------

### Garmin Connect IQ SDK Setup

Source: https://developer.garmin.com/connect-iq/device-reference/instinctcrossover

Instructions for setting up the Connect IQ Software Development Kit (SDK) to begin developing applications for Garmin devices. This typically involves downloading the SDK and configuring your development environment.

```bash
# Download the Connect IQ SDK from the Garmin Developer website
# Example command (actual URL may vary):
# curl -O https://developer.garmin.com/connect-iq/sdk/ConnectIQ-SDK-mac-x64-4.x.x.dmg
```

--------------------------------

### Monkey C Application Object Example

Source: https://developer.garmin.com/connect-iq/monkey-c

This snippet demonstrates the basic structure of a watch face application object in Monkey C, including the onStart, onStop, and getInitialView methods.

```Monkey C
using Toybox.Application as App;
using Toybox.System;

class MyProjectApp extends App.AppBase {

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new MyProjectView() ];
    }
}
```

--------------------------------

### Get Body Battery History Iterator

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/SensorHistory

This example demonstrates how to get a SensorHistoryIterator for body battery data. It checks for SensorHistory compatibility and then retrieves samples, printing the data for each sample. The data ranges from 0 (drained) to 100 (rested).

```Monkey C
using Toybox.SensorHistory;
using Toybox.System;

  // Create a method to get the SensorHistoryIterator object
  function getIterator() {
      // Check device for SensorHistory compatibility
      if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getBodyBatteryHistory)) {
          // Set up the method with parameters
          return Toybox.SensorHistory.getBodyBatteryHistory({});
      }
      return null;
  }
  // get the body battery iterator object
  var bbIterator = getIterator();
  var sample = bbIterator.next();                         // get the body battery data

  while (sample != null) {
      System.println("Sample: " + sample.data);           // print the current sample
      sample = bbIterator.next();
  }
```

--------------------------------

### Handle App Startup and Initialization

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/AppBase

The onStart method is called when the application begins execution, allowing for initialization tasks before the first view is created. It's used to set up application-level settings or retrieve data from the object store. The 'state' parameter provides information about how the app was launched, including resume status, launch source, and configuration details.

```Monkey C
function onStart(state) {
    if (state != null) {
        infoString = "Args:" + state.toString();
    }
}
```

--------------------------------

### Get System Workouts

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of all workouts installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getWorkouts() as PersistedContent.Iterator
```

--------------------------------

### Start Media Sync - Connect IQ

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Media/SyncDelegate

The onStartSync() method is invoked when the system initiates a media sync. This method should manage the sync process, including setting up data fetching, making initial web requests, chaining subsequent requests, and notifying progress and completion.

```Connect IQ
function onStartSync() as Void
```

--------------------------------

### Get System Waypoints

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of all waypoints installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getWaypoints() as PersistedContent.Iterator
```

--------------------------------

### Initialize and Use LightNetwork and LightNetworkListener

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/AntPlus/LightNetwork

This snippet demonstrates how to set up a LightNetwork and its listener to manage bike lights. It shows the initialization of the listener and network, and how to update headlight modes and display the network state.

```Monkey C
using Toybox.AntPlus;

class MyLightNetworkListener extends AntPlus.LightNetworkListener {
    var mNetworkState = 0;

    function onLightNetworkStateUpdate(data) {
        mNetworkState = data;
    }
}

// In app class…
    function initialize() {
        mLightNetworkListener = new MyLightNetworkListener();
        mLightNetwork = new AntPlus.LightNetwork(mLightNetworkListener);
    }

    function onUpdate(dc) {
        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);

        if (null != mLightNetworkListener.mNetworkState) {
            dc.drawText(
                10,
                10,
                Gfx.FONT_TINY,
                mLightNetworkListener.mNetworkState.toString(),
                Gfx.TEXT_JUSTIFY_LEFT);
        }

        if (mode < 15) {
            mode++;
        }
        else {
            mode = 0;
        }
        mLightNetwork.setHeadlightsMode(mode);
    }

```

--------------------------------

### Get System Tracks

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of all tracks installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getTracks() as PersistedContent.Iterator
```

--------------------------------

### JavaScript Callback Example

Source: https://developer.garmin.com/connect-iq/monkey-c

Demonstrates how to pass a function as a callback in JavaScript to handle the completion of a long-running task.

```JavaScript
function wakeMeUpBeforeYouGoGo() {
    // Handle completion
}

// Do a long running thing, and pass callback to call when done.
doLongRunningTask( wakeMeUpBeforeYouGoGo );
```

--------------------------------

### Basic Jungle Build Instruction

Source: https://developer.garmin.com/connect-iq/reference-guides/jungle-reference

Demonstrates the fundamental syntax for a build instruction in a Jungle file, including optional comments and qualifier-value pairs.

```Jungle
# This is a comment
qualifier[.property] = value
```

--------------------------------

### Get System Routes

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of all routes installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getRoutes() as PersistedContent.Iterator
```

--------------------------------

### Get System Courses

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of all courses installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getCourses() as PersistedContent.Iterator
```

--------------------------------

### Garmin Connect IQ: Start Sync Mode

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Communications

The startSync() method allows an application to exit the AppBase and launch directly into sync mode. This is useful for initiating data synchronization processes. It is supported on a wide range of Garmin devices starting from API Level 3.1.0.

```garminsymbol
startSync() as Void
```

--------------------------------

### Request Audio File Download (Monkey C)

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-create-an-audio-content-provider

This snippet demonstrates how a Connect IQ app requests an audio file download from a web API. The backend service then serves the file from a CDN, and the app stores it encrypted on the watch's file system.

```Monkey C
function requestAudioDownload(url) {
    // Use a web API to request an audio file download
    var response = WebRequest.get(url);
    
    // Assume response.data contains the audio file content
    var audioData = response.data;
    
    // Store the downloaded audio file on the watch's file system
    // Content is encrypted as it's written to the filesystem
    Storage.saveFile("downloaded_song.mp3", audioData, Storage.ENCRYPTED);
}
```

--------------------------------

### Get Application Workouts

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of workouts that are owned by the application and installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getAppWorkouts() as PersistedContent.Iterator
```

--------------------------------

### Get Application Waypoints

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of waypoints that are owned by the application and installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getAppWaypoints() as PersistedContent.Iterator
```

--------------------------------

### Garmin Connect IQ AppBase Lifecycle Methods

Source: https://developer.garmin.com/connect-iq/core-topics/application-and-system-modules

This snippet shows the `onAppInstall()` and `onAppUpdate()` methods for the `Application.AppBase` class in Garmin Connect IQ. These methods are triggered during app installation and updates, respectively, and require the `Background` permission. They are not guaranteed to run and should not be relied upon for critical functionality.

```Monkey C
function onAppInstall() {
    // Callback method that is triggered in the background when the app is installed
}

function onAppUpdate() {
    // Callback method that is triggered in the background when the app is updated
}
```

--------------------------------

### Monkey C Duck Typing Example

Source: https://developer.garmin.com/connect-iq/monkey-c

Illustrates Monkey C's duck typing feature, where a function can accept different types of arguments, as shown in the 'add' function example.

```Monkey C
function add( a, b ) {
    return a + b;
}

function thisFunctionUsesAdd() {
    var a = add( 1, 3 ); // Return  4
    var b = add( "Hello ", "World" ); // Returns "Hello World"
}
```

--------------------------------

### Get Application Tracks

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of tracks that are owned by the application and installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getAppTracks() as PersistedContent.Iterator
```

--------------------------------

### Start, Stop, and Save Activity Recording

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/ActivityRecording

This code snippet demonstrates how to create, start, stop, and save an activity recording session using the Toybox.ActivityRecording module. It checks for device support, handles session creation with specified parameters (name, sport, sub-sport), and manages the session lifecycle.

```Monkey C
using Toybox.ActivityRecording;
using Toybox.WatchUi;
var session = null; // set up session variable

// use the select Start/Stop or touch for recording
function onSelect() {
   if (Toybox has :ActivityRecording) { // check device for activity recording
       if ((session == null) || (session.isRecording() == false)) {
           session = ActivityRecording.createSession({ // set up recording session
                 :name=>"Generic", // set session name
                 :sport=>Activity.SPORT_GENERIC, // set sport type
                 :subSport=>Activity.SUB_SPORT_GENERIC // set sub sport type
           });
           session.start(); // call start session
       } else if ((session != null) && session.isRecording()) {
           session.stop(); // stop the session
           session.save(); // save the session
           session = null; // set session control variable to null
       }
   }
   return true; // return true for onSelect function
}
```

--------------------------------

### Get Application Routes

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of routes that are owned by the application and installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getAppRoutes() as PersistedContent.Iterator
```

--------------------------------

### Get Application Courses

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/PersistedContent

Retrieves a collection of courses that are owned by the application and installed on the system. This method returns an iterator for the persisted content.

```Monkey C
getAppCourses() as PersistedContent.Iterator
```

--------------------------------

### Create New Monkey C Project

Source: https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app

Steps to create a new Connect IQ project using the Monkey C extension in an IDE. This involves using the command palette to initiate the 'New Project' command, specifying project name, type (e.g., Watch Face), template (e.g., Simple), and minimum API level.

```Monkey C
// Command Palette: Monkey C: New Project
// Project Name: [Your Project Name]
// Project Type: Watch Face
// Template: Simple
// Minimum API Level: 3.2.0
```

--------------------------------

### Get ByteArray Slice

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Lang/ByteArray

Creates and returns a new ByteArray containing a specified range of elements from the original ByteArray. The slice is defined by start and end indices.

```Monkey C
function slice(startIndex as Lang.Number or Null , endIndex as Lang.Number or Null) as Lang.ByteArray
```

--------------------------------

### Create Media Content Iterator

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-create-an-audio-content-provider

Creates a `Media.ContentIterator` that provides media player with an iterator of `Media.ContentRef` instances. It also supplies a `Media.PlaybackProfile` for customizing the media player interface, including disabling skip buttons and displaying metadata.

```Monkey C
class MyContentIterator extends Media.ContentIterator {

    function initialize() {
        Media.ContentIterator.initialize();
        // Initialize song list and current index
    }

    function getCount() as Number {
        // Return the total number of songs
        return 0;
    }

    function getPage(startIndex as Number, endIndex as Number) as Array<Media.ContentRef> {
        // Return a page of ContentRef objects
        return [];
    }

    function getPlaybackProfile() as Media.PlaybackProfile {
        // Return a PlaybackProfile for UI customization
        var profile = new Media.PlaybackProfile();
        // Configure profile properties like skip button behavior
        return profile;
    }

}
```

--------------------------------

### Full Tweet JSON Example

Source: https://developer.garmin.com/connect-iq/connect-iq-faq/how-do-i-use-rest-services

This snippet provides an example of a complete JSON response from the Twitter API for a single Tweet. It includes various fields that are often unnecessary for a Connect IQ application, highlighting the need for data minimization.

```json
{
  "coordinates": null,
  "favorited": false,
  "truncated": false,
  "created_at": "Mon Sep 24 03:35:21 +0000 2012",
  "id_str": "250075927172759552",
  "entities": {
    "urls": [

    ],
    "hashtags": [
      {
        "text": "freebandnames",
        "indices": [
          20,
          34
        ]
      }
    ],
    "user_mentions": [

    ]
  },
  "in_reply_to_user_id_str": null,
  "contributors": null,
  "text": "Aggressive Ponytail #freebandnames",
  "metadata": {
    "iso_language_code": "en",
    "result_type": "recent"
  },
  "retweet_count": 0,
  "in_reply_to_status_id_str": null,
  "id": 250075927172759552,
  "geo": null,
  "retweeted": false,
  "in_reply_to_user_id": null,
  "place": null,
  "user": {
    "profile_sidebar_fill_color": "DDEEF6",
    "profile_sidebar_border_color": "C0DEED",
    "profile_background_tile": false,
    "name": "Sean Cummings",
    "profile_image_url": "http://a0.twimg.com/profile_images/2359746665/1v6zfgqo8g0d3mk7ii5s_normal.jpeg",
    "created_at": "Mon Apr 26 06:01:55 +0000 2010",
    "location": "LA, CA",
    "follow_request_sent": null,
    "profile_link_color": "0084B4",
    "is_translator": false,
    "id_str": "137238150",
    "entities": {
      "url": {
        "urls": [
          {
            "expanded_url": null,
            "url": "",
            "indices": [
              0,
              0
            ]
          }
        ]
      },
      "description": {
        "urls": [
        ]
      }
    },
    "default_profile": true,
    "contributors_enabled": false,
    "favourites_count": 0,
    "url": null,
    "profile_image_url_https": "https://si0.twimg.com/profile_images/2359746665/1v6zfgqo8g0d3mk7ii5s_normal.jpeg",
    "utc_offset": -28800,
    "id": 137238150,
    "profile_use_background_image": true,
    "listed_count": 2,
    "profile_text_color": "333333",
    "lang": "en",
    "followers_count": 70,
    "protected": false,
    "notifications": null,
    "profile_background_image_url_https": "https://si0.twimg.com/images/themes/theme1/bg.png",
    "profile_background_color": "C0DEED",
    "verified": false,
    "geo_enabled": true,
    "time_zone": "Pacific Time (US & Canada)",
    "description": "Born 330 Live 310",
    "default_profile_image": false,
    "profile_background_image_url": "http://a0.twimg.com/images/themes/theme1/bg.png",
    "statuses_count": 579,
    "friends_count": 110,
    "following": null,
    "show_all_inline_media": false,
    "screen_name": "sean_cummings"
  },
  "in_reply_to_screen_name": null,
  "source": "Twitter for Mac",
  "in_reply_to_status_id": null
}
```

--------------------------------

### Get Elevation History Iterator - Monkey C

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/SensorHistory

This code snippet demonstrates how to get an iterator for elevation history using the `getElevationHistory` function. It includes a check for device compatibility with the SensorHistory module and the specific function. The example retrieves all available history with the newest samples first and prints the data from the most recent sample.

```Monkey C
using Toybox.SensorHistory;
using Toybox.Lang;
using Toybox.System;

// Create a method to get the SensorHistoryIterator object
function getIterator() {
    // Check device for SensorHistory compatibility
    if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getElevationHistory)) {
        return Toybox.SensorHistory.getElevationHistory({});
    }
    return null;
}

// Store the iterator info in a variable. The options are 'null' in
// this case so the entire available history is returned with the
// newest samples returned first.
var sensorIter = getIterator();

// Print out the next entry in the iterator
if (sensorIter != null) {
    System.println(sensorIter.next().data);
}
```

--------------------------------

### Lua Object Creation Example

Source: https://developer.garmin.com/connect-iq/monkey-c

Illustrates creating an object in Lua by binding functions to a hash table, including a constructor function.

```Lua
function doSomethingFunction( me ) {
    // Do something here
}

// Constructor for MyObject
function newMyObject() {
    local result = {};
    result["doSomething"] = doSomethingFunction;
}
```

--------------------------------

### Creating a Simple Connect IQ App

Source: https://developer.garmin.com/connect-iq/device-reference/instinctcrossover

A basic example of a Connect IQ application, likely a watch face or a simple data field. This demonstrates the fundamental structure of a Connect IQ app, including initialization and update methods.

```monkeyc
using Toybox.WatchUi;

class HelloWorldView extends WatchUi.View {

    function initialize() {
        WatchUi.View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onUpdate(dc) {
        var label = View.findDrawableById("label");
        label.setText("Hello, World!");
        View.onUpdate(dc);
    }

}

class HelloWorldApp extends WatchUi.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new HelloWorldView() ];
    }

}

function getApp() {
    return new HelloWorldApp();
}
```

--------------------------------

### Get Millisecond Timer (Monkey C)

Source: https://developer.garmin.com/connect-iq/api-docs/Toybox/System

Retrieves the current millisecond timer value. The timer typically starts at zero on device boot and rolls over periodically.

```Monkey C
using Toybox.System;
var timerValue = System.getTimer();
```

--------------------------------

### Set Fenix 3 English Language Resources

Source: https://developer.garmin.com/connect-iq/reference-guides/jungle-reference

This example configures the resource path for English localization strings for the Fenix 3 device, specifying the 'fenix-resources-eng' directory.

```Jungle
# Set the fenix 3 English language resource location
fenix3.lang.eng = $(fenix3.lang.eng);fenix-resources-eng
```
