TextInput {
    property bool trace: false;
    property Model model;
    DataList {
        model: parent.model;
        trace: parent.trace;
        onCompleted: {
            var element = this.element
            var input = this.parent
            element.remove()
            input.parent.element.append(element)
            input.element.setAttribute("list", this.domId)
        }
    }
}
