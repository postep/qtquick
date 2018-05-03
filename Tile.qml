import QtQuick 2.0

Rectangle {
    id: tile
    property int row;
    property int col;
    property Piece piece;
    property color prevColor
    property var directionToCapture: null
    property bool isLighten: false

    width: 100
    height: width
    color: (row + col) % 2 ? "#b3d1bd" : "darkgreen"

    function lightTile(){
        prevColor = tile.color
        color = Qt.lighter(prevColor, 1.7)
        isLighten = true
    }
    function darkTile(){
        tile.color = prevColor
        isLighten = false
    }
}
