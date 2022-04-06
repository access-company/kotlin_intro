/*
when DOM content is loaded, page shows KotlinPlayground.
case. page reload with browser's reload-button
*/ 
document.addEventListener('DOMContentLoaded', () => {
    KotlinPlayground('.lang-kotlin')
})

/*
when "SOME" DOM is updated, page shows KotlinPlayground.
case. user click left-side buttons and page switching occurre
*/ 

// if title text is changed,
// show KotlinPlayground with KotlinPlayground Func
const target = document.getElementsByTagName('title')[0]
const observer = new MutationObserver(() => {
    // calling KotlinPlayground is heavy.
    // so call setTimeout func to async it.
    setTimeout(() => KotlinPlayground('.lang-kotlin'))
})

// detecting changes on title children
const config = {childList: true}
observer.observe(target, config)
