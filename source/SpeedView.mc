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

	function setValueOffset(offsetY) {
		var value = View.findDrawableById("value");
		value.locY = value.locY + offsetY;
	}

	function onLayout(dc) {
		if (dc.getWidth() < 120) {
			View.setLayout(Rez.Layouts.Edge1kSmall(dc));
			setValueOffset(10);
		} else if (dc.getHeight() < 140) {
			View.setLayout(Rez.Layouts.Edge1kMedium(dc));
			setValueOffset(15);
		} else {
			View.setLayout(Rez.Layouts.Edge1kBig(dc));
			setValueOffset(15);
		}
		var labelText = View.findDrawableById("label");
		labelText.setText(label + " " + unitLabel);
		return true;
	}

	function compute(info) {
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
		if (currSpd < avgSpd) {
			View.findDrawableById("arrows").setArrowType(ArrowContainer.ARROW_DOWN);
		} else if (currSpd > avgSpd) {
			View.findDrawableById("arrows").setArrowType(ArrowContainer.ARROW_UP);
		} else {
			View.findDrawableById("arrows").setArrowType(ArrowContainer.ARROW_NONE);
		}

		View.onUpdate(dc);
	}

}
