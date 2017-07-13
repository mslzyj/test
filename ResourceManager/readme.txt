  
  由于 android1.5 里有android.content.pm.IPackageInstallObserver文件

       android2.0 没有android.content.pm.IPackageInstallObserver文件

  所以在运行本程序时，如果程序中import  android.content.pm.IPackageInstallObserver；出现错误时，请执行下列操作：
  
     1.打开E:\android\android-sdk\platforms\android-10下的android.jar文件（android安装目录里面）
    
     2.打开android.jar中的android文件夹
    
     3.打开android文件夹中的content文件夹
  
     4.打开content文件夹中的pm文件夹
  
     5.将本包内的两个.class文件复制到pm文件中
 
     6.重启android studio软件



    注：可直接运行的 APK 文件在   taskmanager2\app\build\outputs  下