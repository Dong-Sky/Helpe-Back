<?php

function classLoader($class)
{
    $lib_root = __DIR__ . DIRECTORY_SEPARATOR .'src'. DIRECTORY_SEPARATOR .'notification'. DIRECTORY_SEPARATOR;
    $file = "";
    switch($class){
        case "UmengNotification":
            $file = $lib_root."UmengNotification.php";
            break;
        case "IOSNotification":
            $file = $lib_root."IOSNotification.php";
            break;
        case "AndroidNotification":
            $file = $lib_root."AndroidNotification.php";
            break;
        case "IOSBroadcast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSBroadcast.php";
            break;
        case "IOSCustomizedcast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSCustomizedcast.php";
            break;
        case "IOSFilecast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSFilecast.php";
            break;
        case "IOSGroupcast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSGroupcast.php";
            break;
        case "IOSListcast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSListcast.php";
            break;
        case "IOSUnicast":
            $file = $lib_root."ios".DIRECTORY_SEPARATOR."IOSUnicast.php";
            break;
        case "AndroidBroadcast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidBroadcast.php";
            break;
        case "AndroidCustomizedcast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidCustomizedcast.php";
            break;
        case "AndroidFilecast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidFilecast.php";
            break;
        case "AndroidGroupcast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidGroupcast.php";
            break;
        case "AndroidListcast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidListcast.php";
            break;
        case "AndroidUnicast":
            $file = $lib_root."android".DIRECTORY_SEPARATOR."AndroidUnicast.php";
            break;

    }

    if(file_exists($file)){
        require_once $file;
    }

}
spl_autoload_register('classLoader');