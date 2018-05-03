import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQml.StateMachine 1.0 as DSM


Item {
    id: item
    property var turnState: "redTurn"
    property var resetButton: resetButton
    property var startTime: new Date()
    property var timer: timer
    property alias timerVisible: timeText.visible
    RowLayout {
        id: row
        anchors.rightMargin: 26
        anchors.leftMargin: 25
        anchors.bottomMargin: 25
        anchors.topMargin: 25
        anchors.fill: parent

        ColumnLayout {
            width: 200
            height: 200
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    id: timeText
                    anchors.centerIn: parent
                    color: "darkgreen"
                    text: qsTr("Czas gry: ")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 18
                    Timer {
                        id: timer
                           interval: 1000
                           running: true
                           repeat: true
                           triggeredOnStart: true
                           onTriggered: {
                               var diff = new Date() - startTime
                               diff = (diff /1000) | 0
                               var mins = (diff/60) | 0
                               var secs = diff%60
                               var secsString = secs.toString()
                               if(secs < 10){
                                   secsString = "0" + secsString
                               }

                               timeText.text = "Czas gry:\n" + mins.toString()+":"+secsString
                           }
                       }

                }
            }


            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    id: turnText
                    anchors.centerIn: parent
                    color: "red"
                    text: "ruch"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 18
                    state: "redTurn"
                    Layout.fillHeight: true
                    states:[
                        State{
                            name: "redTurn"
                            PropertyChanges {
                                target: turnText
                                color: "red"
                                text: "Czerwone"
                            }
                            when: turnState === "redTurn"

                        },
                        State{
                            name: "blackTurn"
                            PropertyChanges {
                                target: turnText
                                color: "darkgray"
                                text: "Czarne"
                            }
                            when: turnState === "blackTurn"
                        },

                        State{
                            name: "blackWin"
                            PropertyChanges {
                                target: turnText
                                color: "darkgray"
                                text: "WYGRANA\nCZARNYCH"
                            }
                            when: turnState === "blackWin"
                        },
                        State{
                            name: "redWin"
                            PropertyChanges {
                                target: turnText
                                color: "red"
                                text: "WYGRANA\nCZERWONYCH"
                            }
                            when: turnState === "redWin"
                        }
                    ]
                }
            }

            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Button{
                    id: resetButton
                    text: "Zresetuj"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
