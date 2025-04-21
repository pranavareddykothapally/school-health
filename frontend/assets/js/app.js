const currentPath = window.location.pathname.split("/").pop();
document.querySelectorAll('.nav-link').forEach(link => {
  if (link.getAttribute('href') === currentPath) {
    link.classList.add('active');
  } else {
    link.classList.remove('active');
  }
});

// Optional: Scroll to top on navigation (if using anchors or internal routing)
document.querySelectorAll('a.nav-link').forEach(link => {
  link.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
});

// Form Validation Example
const form = document.querySelector('form');
if (form) {
  form.addEventListener('submit', function (e) {
    const inputs = form.querySelectorAll('input');
    let valid = true;

    inputs.forEach(input => {
      if (!input.value.trim()) {
        input.classList.add('is-invalid');
        valid = false;
      } else {
        input.classList.remove('is-invalid');
      }
    });

    if (!valid) {
      e.preventDefault();
      alert('Please fill in all required fields.');
    }
  });
}