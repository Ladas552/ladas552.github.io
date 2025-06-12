// Update scroll percentage
function updateScrollPercentage() {
  const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  const scrollHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrollPercentage = scrollHeight > 0 ? Math.round((scrollTop / scrollHeight) * 100) : 0;

  const locationElement = document.getElementById('scroll-percentage');
  const textMap = { 0: 'Top', 100: 'Bot', 99: 'Bot'};
  locationElement.textContent = textMap[scrollPercentage] || scrollPercentage + '%';
}

// Update on scroll
window.addEventListener('scroll', updateScrollPercentage);
// Update on window resize
window.addEventListener('resize', updateScrollPercentage);

// Update on page load
document.addEventListener('DOMContentLoaded', updateScrollPercentage);
