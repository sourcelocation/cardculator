import CardculatorC

func log(_ objs: Any...) {
    let string = objs.map { String(describing: $0) }.joined(separator: "; ")
    let args: [CVarArg] = [ "[Cardculator-\(Date().description)] \(string)" ]
    withVaList(args) { RLogv("%@", $0) }
}
