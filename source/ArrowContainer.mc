using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class ArrowContainer extends Ui.Drawable {

	static var ARROW_UP = 1;
	static var ARROW_DOWN = 2;
	static var ARROW_NONE = 0;

	static var PADDING = 4;
	static var PADDING_RIGHT = 6;

	hidden var arrowType,
	offsetY;

	function initialize(params) {
		Drawable.initialize(params);
		offsetY = params.get( : offsetY);
	}

	function setArrowType(type) {
		arrowType = type;
	}

	function getArrow(width) {
		if (arrowType == ARROW_UP) {
			return [[0, width], [width / 2, 0], [width, width]];
		} else {
			return [[0, 0], [width / 2, width], [width, 0]];
		}
	}

	function calculateArrowAboveBelowCenter(dc) {
		var x = dc.getWidth() / 2;
		var vCenter = dc.getHeight() / 2;
		var y;
		if (arrowType == ARROW_UP) {
			y = vCenter / 2;
			y -= PADDING;
		} else {
			y = vCenter / 2 + vCenter;
			y += PADDING;
		}

		y += offsetY;

		return [x, y];
	}

	function drawArrowAboveBelow(dc, arrow) {
		var arrowCenter = calculateArrowAboveBelowCenter(dc);
		var arrowMoved = moveArrowCenterTo(arrow, arrowCenter);
		dc.fillPolygon(arrowMoved);
	}

	function getArrowWidth(arrow) {
		return (arrow[2][0] - arrow[0][0]).abs();
	}

	function getArrowHeight(arrow) {
		return (arrow[1][1] - arrow[0][1]).abs();
	}

	function moveArrowCenterTo(arrow, position) {

		var offsetX = position[0] - getArrowWidth(arrow) / 2;
		var offsetY = position[1] - getArrowHeight(arrow) / 2;

		var newArrow = new[arrow.size()];
		for (var i = 0; i < arrow.size(); i++) {
			newArrow[i] = new[2];
			newArrow[i][0] = arrow[i][0] + offsetX;
			newArrow[i][1] = arrow[i][1] + offsetY;
		}
		return newArrow;
	}

	function calculateArrowToRight(dc, arrow) {
		var arrowWidth = getArrowWidth(arrow);
		var arrowHeight = getArrowHeight(arrow) / 2;
		var x = dc.getWidth() - arrowWidth / 2 - PADDING_RIGHT;

		var vCenter = dc.getHeight() / 2;
		var y;
		if (arrowType == ARROW_UP) {
			y = vCenter - arrowHeight / 2;
			y -= PADDING;
		} else {
			y = vCenter + arrowHeight / 2;
			y += PADDING;
		}
		y += offsetY;
		return [x, y];

	}
	
	function calculateArrowToMediumRight(dc, arrow) {
		var arrowWidth = getArrowWidth(arrow);
		var arrowHeight = getArrowHeight(arrow);
		var x = dc.getWidth() * 5 / 6;

		var vCenter = dc.getHeight() / 2;
		var y;
		if (arrowType == ARROW_UP) {
			y = vCenter - arrowHeight / 2;
			y -= PADDING;
		} else {
			y = vCenter + arrowHeight / 2;
			y += PADDING;
		}
		y += offsetY;
		return [x, y];

	}

	function drawArrowToRight(dc, arrow) {
		var arrowCenter = calculateArrowToRight(dc, arrow);
		var arrowMoved = moveArrowCenterTo(arrow, arrowCenter);
		dc.fillPolygon(arrowMoved);
	}
	
	function drawArrowToMediumRight(dc, arrow) {
		var arrowCenter = calculateArrowToMediumRight(dc, arrow);
		var arrowMoved = moveArrowCenterTo(arrow, arrowCenter);
		dc.fillPolygon(arrowMoved);
	}

	function draw(dc) {
		var fillColorArrow = Gfx.COLOR_RED;
		if (arrowType == ARROW_UP) {
			fillColorArrow = Gfx.COLOR_GREEN;
		}
		dc.setColor(fillColorArrow, Gfx.COLOR_TRANSPARENT);

		if (dc.getHeight() > 250) {
			drawArrowAboveBelow(dc, getArrow(100));
		} else if (dc.getHeight() > 180) {
			drawArrowAboveBelow(dc, getArrow(50));
		} else {
			if (dc.getWidth() < 200) {
				drawArrowToRight(dc, getArrow(25));
			} else {
				drawArrowToMediumRight(dc, getArrow(30));
			}
		}

	}

}
