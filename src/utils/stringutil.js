export function leftPadding (str, total, padding) {
    let i
    let result = str
    if (str.length < total) {
        for (i = str.length; i < total; i += 1) {
            result = `${padding}${result}`
        }
    }
    return result
}

export function canonicalActors (actors) {
    return actors.split(',').join('/')
}
