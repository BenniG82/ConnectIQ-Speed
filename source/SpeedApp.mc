using Toybox.Application as App;

class SpeedApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new SpeedView() ];
    }

}