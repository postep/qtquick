import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Warcaby")
    color: "white"
    menuBar: MenuBar {
            Menu {
                title: "Warcaby"
                MenuItem {
                    id: show
                    text: "&Pokaż zaawansowane"
                    onTriggered: {
                        dashboard.timerVisible = !dashboard.timerVisible
                    }
                }
                MenuItem {
                    id: quit
                    text: "&Zamknij"
                    onTriggered: Qt.quit()
                }
            }
    }
    RowLayout{
        anchors.fill: parent
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 50
            Layout.preferredWidth: 100
            Layout.maximumWidth: 200
            Dashboard{
                id: dashboard
                anchors.fill: parent
                width: 200
                height: 2*width
                scale: Math.min(parent.width/width, parent.height/height)
                turnState: board.turnState
            }
        }

        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            Layout.minimumWidth: 50
            Board{
                id: board
                anchors.centerIn: parent
                width: 800
                height: width
                scale: Math.min(parent.width/width, parent.height/height)
            }
        }

        Connections{
            target: dashboard.resetButton
            onClicked: {
                board.init()
                dashboard.startTime = new Date().getTime()
                dashboard.timer.restart()
            }
        }

        Connections{
            target: board
            onStopTimer: {
                dashboard.timer.stop()
            }
        }
        Connections{
            target: board
            onStartTimer: {
                dashboard.timer.restart()
            }
        }
    }

}
