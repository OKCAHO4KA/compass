# Miscelaneos


ANDROID:

<!--renombrar bundleId: con un package  - change_app_package_name en developer dependencies
flutter pub run change_app_package_name:main com.xana.miscelaneos-->



  <!-- de doc.of copy /paste this code in AndroidManifest antes de </activity>
  
  <meta-data android:name="flutter_deeplinking_enabled" android:value="true" /> 
     <intent-filter android:autoVerify="true">
     <action android:name="android.intent.action.VIEW" />
     <category android:name="android.intent.category.DEFAULT" />
     <category android:name="android.intent.category.BROWSABLE" />
     <data android:scheme="http" android:host="example.com" />
     <data android:scheme="https" />
 </intent-filter> -->

<!-- SHA256

cd android
./gradlew signingReport
 -->


<!-- nuestro domain :

https://pokemon-deeplink.up.railway.app/

.well-known/assetlinks.json
  -->
