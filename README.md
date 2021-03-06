# DECIDIM.Hackovid.APP

This is a Decidim app for the Hackovid site

## Overrides

### Topbar menu

Check the `Rails.application.config.to_prepare` block in `config/initializers/decidim.rb` initializer.

### Recaptcha

To provide recaptcha capabilities the `recaptcha` gem is used.
The implementation tweaks:

- *render the recaptcha widget*: app/overrides/decidim/devise/registrations/new/recaptcha.html.erb.deface
- *check if recaptcha is valid in the controller*: app/decorators/decidim/devise/registrations_controller_decorator.rb
- The recaptcha js tag that should appear in all views has been set via admin panel Configuration / Appearance

### Proposals

There are some overrides that must be checked on every upgrade:

- app/views/decidim/proposals/proposals/\_filters.html.erb hides some filters
- app/views/decidim/proposals/proposals/show.html.erb:73
  - hides the follow button
  - hides the versioning of the proposal

### Styling

#### Custom CSS & JavaScript

```
<style>
/* line 9, app/assets/stylesheets/application.scss */
.title-bar {
  background: #fff;
  color: #1a181d;
}

/* line 14, app/assets/stylesheets/application.scss */
.topbar__dropmenu > ul > li > a {
  color: #1a181d;
}

/* line 18, app/assets/stylesheets/application.scss */
.topbar__dropmenu > ul > li > a::after {
  border-top-color: #1a181d !important;
}

/* line 22, app/assets/stylesheets/application.scss */
.topbar__user__login a {
  color: #1a181d;
  font-weight: 600;
}

/* line 27, app/assets/stylesheets/application.scss */
.logo-wrapper {
  display: inline-block;
  line-height: 0;
  flex-grow: 1;
}

/* line 32, app/assets/stylesheets/application.scss */
.logo-wrapper a {
  display: inline-block;
}

/* line 36, app/assets/stylesheets/application.scss */
.logo-wrapper img {
  max-height: 33px;
}

@media print, screen and (min-width: 50em) {
  /* line 36, app/assets/stylesheets/application.scss */
  .logo-wrapper img {
    max-height: 40px;
  }
}

/* line 45, app/assets/stylesheets/application.scss */
.topbar__edit__link a:hover {
  color: #2c2930;
}

/* line 49, app/assets/stylesheets/application.scss */
.topbar__edit__link a {
  color: #1a181d;
}

/* line 53, app/assets/stylesheets/application.scss */
.main-footer {
  background-color: #e8e8e8;
  color: #e8e8e8;
}

/* line 58, app/assets/stylesheets/application.scss */
.topbar__notifications .icon,
.topbar__conversations .icon {
  fill: #1a181d;
  opacity: .9;
}

/* line 63, app/assets/stylesheets/application.scss */
.topbar__search input, .topbar__search input:focus, .topbar__search input::-webkit-input-placeholder {
  background: #e8e8e8;
  color: #3d393c;
}
.topbar__search input, .topbar__search input:focus, .topbar__search input:-ms-input-placeholder {
  background: #e8e8e8;
  color: #3d393c;
}
.topbar__search input, .topbar__search input:focus, .topbar__search input::-ms-input-placeholder {
  background: #e8e8e8;
  color: #3d393c;
}
.topbar__search input, .topbar__search input:focus, .topbar__search input::placeholder {
  background: #e8e8e8;
  color: #3d393c;
}

/* line 67, app/assets/stylesheets/application.scss */
.topbar__search svg {
  color: #2c2930;
}

/**** subheader*****/

.navbar{
  background: rgb(234,84,81);
}
.main-nav__link a{
  color: rgba(255,255,255, 0.8);
}
.main-nav__link a:hover{
  // background: grey;
  color: white;
}

.main-nav__link--active a{
  box-shadow: inset 0 4px 0 0 grey;
  background: rgba(255, 255, 255, 0.2);
  color: white
}
.main-nav__link--active a:hover{
  background: rgba(255, 255, 255, 0.2);
}
@media print, screen and (min-width: 40em){
  .main-nav__link--active a{
    box-shadow: inset 0 4px 0 0 grey;
  }
}

/*** hide follow buttons****/
.card--proposal .follow_status{
  display: none;
}

/*** hide process menu button for process ***/
.process-nav__link[href="/processes/solucions-hackovid"]{
  display: none;
}
</style>
<script src='https://www.google.com/recaptcha/api.js'></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-162817045-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-162817045-1');
</script>
```
## Content block HTML at the homepage

```html
<style>
  .home-section.calendar-home-block > .row.title{ background: grey; color: white; font-size: 32px; padding-top: 3px; padding-bottom: 3px; }
</style>

<section class="extended home-section calendar-home-block">
  <div class="row title collapse">
    <div class="small-12 columns text-center">
      CALENDARI
    </div>
  </div>
  <div class="row collapse">
    <div class="small-12 medium-6 large-3 columns">
      <img src="/images/fase_1.png" class="calendar-image-block">
    </div>
    <div class="small-12 medium-6 large-3 columns">
      <img src="/images/fase_2.png" class="calendar-image-block">
    </div>
    <div class="small-12 medium-6 large-3 columns">
      <img src="/images/fase_3.png" class="calendar-image-block">
    </div>
    <div class="small-12 medium-6 large-3 columns">
      <img src="/images/fase_4.png" class="calendar-image-block">
    </div>
  </div>
</section>


<style>
  .home-entry-section .home-entry-section-block{ width: 100%; position: relative; }
  .home-entry-section .home-entry-section-block.first{background: rgb(234, 84,91);}
  .home-entry-section .home-entry-section-block.first{background: grey;}
  .home-entry-section .home-entry-section-block .home-entry-section-description{ position: absolute; bottom: 10px; left: 10px; color: white; width: 90%;}
  .home-entry-section .home-entry-section-block .home-entry-section-description h3{font-size: 18px;}
  .home-entry-section .home-entry-section-block .home-entry-section-description a.home-entry-section-links{ display: block; color: #ccc; }
  .home-entry-section .home-entry-section-block .home-entry-section-description a.home-entry-section-links:hover{ color: #fff; }
</style>


<section class="wrapper-home home-section home-entry-section">
  <div class="row">
    <div class="small-12 medium-6 columns">
      <div class="home-entry-section-block first">
        <img src="/images/ciutadania.png">
        <div class="home-entry-section-description">
          <h3>CIUTADANIA</h3>
          <a href="/processes/solucions-hackovid/f/86/" class="home-entry-section-links">Vota i proposa necessitats ></a>
          <a href="#">&nbsp;</a>
        </div>
      </div>
    </div>
    <div class="small-12 medium-6 columns">
      <div class="home-entry-section-block second">
        <img src="/images/comunitat-tic.png">
        <div class="home-entry-section-description">
          <h3>COMUNITATS TIC</h3>
          <a href="https://docs.google.com/forms/d/e/1FAIpQLSfpXhHVMrwm7MrPycTynvKOOcZdQQtO2MsWModVfPTO9d3qDw/viewform" class="home-entry-section-links" target="_blank">Forma el teu equip i inscriu-te ></a>
          <a href="https://drive.google.com/file/d/1X0Pupd4vteM6al4I7OCXe_1iKddvzrfh/view?usp=sharing"  class="home-entry-section-links" target="_blank">Descarrega les bases ></a>
        </div>
      </div>
    </div>
  </div>
</section>
  


<style>
  .home-entry-section .home-partners-section img{width: 100%;}
</style>

<section class="extended home-section home-partners-section">
  <div class="row title collapse">
    <div class="small-12 columns text-center">
      <img src="/images/banner-organitzadors-patrocinadors.png">
    </div>
  </div>
</section>
```