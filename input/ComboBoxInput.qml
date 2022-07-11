TextInput {
    property bool trace: false;
    property Model model;
    property string valueProperty: "value";

    DataList {
        model: parent.model;
        trace: parent.trace;
        valueProperty: parent.valueProperty;

        onCompleted: {
            var element = this.element
            var input = this.parent
            element.remove()
            input.parent.element.append(element)
            input.element.setAttribute("list", this.domId)
        }
    }
}
