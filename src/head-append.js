document.addEventListener('DOMContentLoaded', () => {
    KotlinPlayground('.lang-kotlin')
})

const target = document.getElementsByTagName('title')[0]
const observer = new MutationObserver(() => {
    setTimeout(() => KotlinPlayground('.lang-kotlin'))
})

const config = {childList: true}
observer.observe(target, config)
