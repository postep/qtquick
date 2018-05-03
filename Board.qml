import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: board

    property Tile clickedTile: null
    property var possibleTiles: []
    property alias turnState: board.state

    state: "redTurn"
    states: [
        State{
            name: "redTurn"
            PropertyChanges {
                target: board
                rotation: 180
            }
        },
        State{
            name: "blackTurn"
            PropertyChanges {
                target: board
                rotation: 0
            }
        },
        State{
            name: "redWin"
            PropertyChanges {
                target: board
                rotation: 180
            }
        },
        State{
            name: "blackWin"
            PropertyChanges {
                target: board
                rotation: 0
            }
        }

    ]

    Behavior on rotation {

                NumberAnimation {
                    duration: 1200
                    //This selects an easing curve to interpolate with, the default is Easing.Linear
                    easing.type: Easing.InOutQuad
                }
            }


    Grid{
        id: grid
        rows: 8
        columns: 8
        Repeater {
            id: tilesRepeater
            model: 64
            Tile{
                id: tile
                row: index / 8
                col: index % 8

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(clickedTile == null){
                            //zaden pionek nie jest zaznaczony
                            if(canMove(tile)){
                                setPossibles(tile);
                                lightTiles();
                                clickedTile = tile;
                            }
                        }else{
                            if(!tile.isLighten){
                                //zmiana pionka do ruchu
                                darkTiles()
                                possibleTiles = []
                                clickedTile = null
                                if(canMove(tile)){
                                    setPossibles(tile)
                                    lightTiles()
                                    clickedTile = tile
                                }
                            }else{
                                var between = getTileBetween(tile, clickedTile)
                                if(between != null){
                                    between.piece.setTeam("none")
                                }

                                tile.piece.setTeam(clickedTile.piece.team)
                                if(!checkWin(tile)){
                                    clickedTile.piece.setTeam("none")
                                    darkTiles()
                                    clickedTile = null
                                    possibleTiles = []
                                    if(board.state == "redTurn"){
                                        board.state = "blackTurn"
                                    }else{
                                        board.state = "redTurn"
                                    }
                                }
                            }
                        }
                    }
                }

                Component.onCompleted: {
                    var component = Qt.createComponent("Piece.qml");
                    tile.piece = component.createObject(tile);
                    tile.piece.anchors.centerIn = tile
                }
            }
        }
        Component.onCompleted: init()
    }

    function canMove(tile){
        return (tile.piece != null &&
                ((tile.piece.team == "black" && board.state == "blackTurn") ||
                 (tile.piece.team == "red" && board.state == "redTurn")));
    }



    function getTile(row, col){
        if(row < 8 && row >= 0 && col < 8 && col >= 0){
            var index = row*8+col
            return tilesRepeater.itemAt(index)
        }else{
            return null
        }
    }

    function getTileBetween(t1, t2){
        if (Math.abs(t1.row - t2.row) == 2 && Math.abs(t1.col - t2.col) == 2){
            var row = (t1.row + t2.row)/2
            var col = (t1.col + t2.col)/2

            return getTile(row, col)
        }else{
            return null
        }

    }

    function nextRightTile(tile, reverse){
        if ((tile.piece.team == "black" && !reverse) || (tile.piece.team == "red" && reverse)){
            return getTile(tile.row-1, tile.col+1);
        }else if((tile.piece.team == "red" && !reverse) || (tile.piece.team == "black" && reverse)){
            return getTile(tile.row+1, tile.col+1);
        }
    }

    function nextLeftTile(tile, reverse){
        if ((tile.piece.team == "black" && !reverse) || (tile.piece.team == "red" && reverse)){
            return getTile(tile.row-1, tile.col-1);
        }else if((tile.piece.team == "red" && !reverse) || (tile.piece.team == "black" && reverse)){
            return getTile(tile.row+1, tile.col-1);
        }
    }

    function oppositeTeam(tile){
        if(tile.piece.team == "red"){
            return "black"
        }
        if(tile.piece.team == "black"){
            return "red"
        }
        return "none"
    }

    function setPossibles(tile){
        var leftToAdd = null
        var lt = nextLeftTile(tile, false)
        if(lt != null){
            if(lt.piece.team == oppositeTeam(tile)){
                var nlt = nextLeftTile(lt, true);
                if(nlt != null && nlt.piece.team == "none"){
                    leftToAdd = nlt
                }
            }
            if(lt.piece.team == "none"){
                leftToAdd = lt
            }
        }

        if(leftToAdd != null){
            possibleTiles.push(leftToAdd)
        }

        var rightToAdd = null
        var rt = nextRightTile(tile, false)
        if(rt != null){
            if(rt.piece.team == oppositeTeam(tile)){
                var nrt = nextRightTile(rt, true);
                if(nrt != null && nrt.piece.team == "none"){
                    rightToAdd = nrt
                }
            }
            if(rt.piece.team == "none"){
                rightToAdd = rt
            }
        }

        if(rightToAdd != null){
            possibleTiles.push(rightToAdd)
        }
    }

    function lightTiles(){
        for(var i = 0; i < possibleTiles.length; ++i){
            possibleTiles[i].lightTile()
        }
    }

    function darkTiles(){
        for(var i = 0; i < possibleTiles.length; ++i){
            possibleTiles[i].darkTile()
        }
    }

    function init(){
        for(var row = 0; row < 8; ++row){
            for(var col = 0; col < 8; ++col){
                var tile = getTile(row, col)
                tile.piece.setTeam("none")
                if(row % 2 == col % 2)
                {
                    if(tile.row <= 2){
                        tile.piece.setTeam("red")
                    }
                    else if(tile.row >= 5){
                        tile.piece.setTeam("black")
                    }
                }
            }
        }
        board.state = "redTurn"
    }

    function checkWin(tile){
        console.log(tile.row);
        if(tile.piece.team == "red" && tile.row == 7){
            board.state = "redWin"
            return true;
        }

        if(tile.piece.team == "black" && tile.row == 0){
            board.state = "blackWin"
            return true;
        }

        return false;
    }
}

