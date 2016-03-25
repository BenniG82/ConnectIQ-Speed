using Toybox.Application as App;

class SpeedApp extends App.AppBase {

    function getInitialView() {
        return [ new SpeedView() ];
    }

}