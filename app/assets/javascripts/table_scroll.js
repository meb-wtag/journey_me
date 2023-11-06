const lenis = new Lenis()

lenis.on('scroll', (e) => {
  console.log(e)
})

function raf(time) {
  lenis.raf(time)
  requestAnimationFrame(raf)
}

requestAnimationFrame(raf)

const table = document.querySelector('.responsive-table');
const rows = document.querySelectorAll('.table-content li');

gsap.registerPlugin(ScrollTrigger);

// Calculate the total height of all rows
const totalHeight = 45 * rows.length;

let scrollTween = gsap.to(rows, {
  y: -totalHeight,
  ease: 'none',
  scrollTrigger: {
    trigger: table,
    pin: true,
    scrub: 1,
    end: `+=${totalHeight}`, // Scroll to the end of the content
    markers: true
    }
});
