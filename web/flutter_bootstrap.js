{{flutter_js}}
{{flutter_build_config}}

const progressBar = document.getElementById('progress_bar');
const progressText = document.getElementById('progress_text');
const statusText = document.getElementById('status_text');
const loaderWrapper = document.getElementById('loading_indicator');

window.addEventListener('load', function() {
  if (window._flutter && window._flutter.loader) {
    window._flutter.loader.load({
      onProgress: function(value) {
        console.log("Loading progress:", value);
        
        const percent = Math.round(value * 100);
        if (progressBar) progressBar.style.width = percent + '%';
        if (progressText) progressText.textContent = percent + '%';

        if (statusText) {
          if (percent < 40) statusText.textContent = "Downloading engine...";
          else if (percent < 80) statusText.textContent = "Preparing assets...";
          else statusText.textContent = "Finalizing...";
        }
      },
      onEntrypointLoaded: async function(engineInitializer) {
        const appRunner = await engineInitializer.initializeEngine();
        
        if (loaderWrapper) {
          loaderWrapper.style.opacity = '0';
          setTimeout(() => loaderWrapper.remove(), 400);
        }
              
        await appRunner.runApp();
      }
    });
  }
});