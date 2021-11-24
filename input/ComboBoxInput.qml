TextInput {
    property Model model;
    DataList {
        model: parent.model;
        trace: true;
        onCompleted: {
            var element = this.element
            var input = this.parent
            element.remove()
            input.parent.element.append(element)
            input.element.setAttribute("list", this.domId)
        }
    }
}
