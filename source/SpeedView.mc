using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SpeedView extends Ui.DataField {

    hidden var currSpd;
    hidden var avgSpd;

    hidden var factor = 3.6;
    hidden var label;
    hidden var unitLabel;

    function initialize() {
        unitLabel = Ui.loadResource(Rez.Strings.unitMetric);
        label = Ui.loadResource(Rez.Strings.speed);
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            factor = 2.2369362920544;
            unitLabel = Ui.loadResource(Rez.Strings.unitImperial);
        }
        DataField.initialize();
    }

    //! Set your layout here. Anytime the size of obscurity of
    //! the draw context is changed this will be called.
    function onLayout(dc) {
        System.println("Width: " + dc.getWidth() + ", Height:" + dc.getHeight());
        if (dc.getWidth() < 120) {
            View.setLayout(Rez.Layouts.Edge1kSmall(dc));
            var value = View.findDrawableById("value");
            value.locY = value.locY + 10;
        } else {
            View.setLayout(Rez.Layouts.Edge1kBig(dc));
            var value = View.findDrawableById("value");
            value.locY = value.locY + 15;
        }
        var labelText = View.findDrawableById("label");
        labelText.setText(label + " " + unitLabel);
        return true;
    }

    //! The given info object contains all the current workout
    //! information. Calculate a value and save it locally in this method.
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        currSpd = info.currentSpeed;
        avgSpd = info.averageSpeed;
        if (currSpd == null) {
            currSpd = 0;
        }
        if (avgSpd == null) {
            avgSpd = 0;
        }

    }

    function formatSpd(spd) {
        var speedInUnit = spd * factor;
        var format = "%3.1f";
        return speedInUnit.format(format);
    }

    //! Display the value you computed here. This will be called
    //! once a second when the data field is visible.
    function onUpdate(dc) {
        View.findDrawableById("Background").setColor(getBackgroundColor());

        var fgColor = Gfx.COLOR_BLACK;
        if (getBackgroundColor() == Gfx.COLOR_BLACK) {
            fgColor = Gfx.COLOR_WHITE;
        }
        var label = View.findDrawableById("label");
        var value = View.findDrawableById("value");

        label.setColor(fgColor);
        value.setColor(fgColor);

        value.setText(formatSpd(currSpd));
        View.onUpdate(dc);

        //dc.fillRectangle(0,0, dc.getWidth(), dc.getHeight());
        /*
        if (currSpd == null || avgSpd == null) {
        return;
        }
        var arrWidth = dc.getWidth() / 6;
        var padding = 10;
        var offset = 15;
        var maxX = dc.getWidth() - padding;
        var minX = maxX - arrWidth;
        var avgX = maxX - arrWidth / 2;

        var valHeight = (dc.getHeight() - padding);
        var minY = offset + (valHeight / 2) - arrWidth;

        if (currSpd < avgSpd) {
        minY = offset + (valHeight / 2);
        }

        if ((minY + arrWidth) > dc.getHeight() || (minY < 0)) {
        minY = dc.getHeight() / 2 - arrWidth / 2;
        }

        var maxY = minY + arrWidth;

        // Default arrow up and green
        var arrow = [ [minX, maxY], [avgX, minY], [maxX, maxY] ];
        var fillColorArrow = Gfx.COLOR_GREEN;

        // Arrow down if current smaller than average
        if (currSpd < avgSpd) {
        arrow = [ [minX, minY], [avgX, maxY], [maxX, minY] ];
        fillColorArrow = Gfx.COLOR_RED;
        }

        dc.setColor(fillColorArrow, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(arrow);

        dc.setColor(fgColor, Gfx.COLOR_TRANSPARENT);
        dc.drawText( padding, padding, Gfx.FONT_SMALL, label + " " + unitLabel , Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText( padding, dc.getHeight() / 2 -5, Gfx.FONT_LARGE, formatSpd(currSpd), Gfx.TEXT_JUSTIFY_LEFT);
         */

    }

}
