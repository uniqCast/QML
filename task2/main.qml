import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0

Window {
    id: root
    visible: true
    height: 500
    width: 1000
    minimumHeight: 400
    minimumWidth: 250
    title: qsTr("Task 2")
    color: "#000"

    Rectangle {
        id: frame
        color: "#333333"
        anchors.centerIn: parent
        height: root.height-100
        width: root.width - 40

        ListView {
            id: view
            anchors.fill: parent
            anchors.margins: 10
            orientation: ListView.Horizontal
            clip: true
            focus: true
            boundsBehavior: Flickable.DragOverBounds
            highlightMoveDuration: 200
            model: movieXml
            delegate: movieDelegate
        }

        XmlListModel {
            id: movieXml
            source: "qrc:///movieModel.xml"
            query: "/movieModel/movie"
            XmlRole {name: "name"; query: "name/string()"}
            XmlRole {name: "year"; query: "year/string()"}
            XmlRole {name: "rating"; query: "rating/string()"}
            XmlRole {name: "image"; query: "image/string()"}
        }

        Component {
            id: movieDelegate

            Rectangle {
                id: column
                color: "#333333"
                width: frame.width<300 ? frame.width/3 : frame.width/5
                height: ListView.view.height

                Image {
                    id: image1
                    scale: column.focus ? 1 : 0.9
                    Behavior on scale {NumberAnimation{duration: 100}}
                    antialiasing: true
                    source: image
                    width: column.width
                    height: column.height - 55
                    fillMode: Image.PreserveAspectFit
                    MouseArea {
                        anchors.fill: parent
                        onClicked: view.currentIndex = index
                    }
                }
                Text {
                    id: text
                    anchors.top: image1.bottom
                    width: parent.width
                    height: column.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: name + " (" + year + ")"
                }
                Text {
                    anchors.top: text.bottom
                    anchors.horizontalCenter: column.horizontalCenter
                    visible: column.focus ? true : false
                    color: "white"
                    text: rating
                }
            }
        }
    }
}
