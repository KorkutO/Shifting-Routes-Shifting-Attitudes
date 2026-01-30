# Shifting-Routes-Shifting-Attitudes
README — Data construction notebooks

1) Geolocations of choke points and natural harbours

Natural harbours
- Notebook: ...\Paper2_Final\NaturalHarbour\NaturalHarbourLocations.ipynb
- Input data: ...\Paper2_Final\NaturalHarbour\WPI_Shapefile\WPI.shp

Choke points
- Notebook: ...\Paper2_Final\Geolocation of Choke Points\Geolocation_ChokePoints.ipynb

2) Geolocations of ethnolinguistic groups Integrated Values Surveys (IVS) and Folklore Catalogue

Integrated Values Surveys (IVS): ethnolinguistic locations and distances
- Notebook: ...\Paper2_Final\IVS_ethnlingLoc_Distances.ipynb

IVS respondents: contemporary locations
- Produced within: ...\Paper2_Final\IVS_ethnlingLoc_Distances.ipynb

Folklore Catalogue (Berezkin): ethnolinguistic group locations and distance controls
- Notebook: ...\Paper2_Final\pre_industrial\Berezkin_Location_Distances_Controls.ipynb


3) Distance computation

Distances (in kilometers) are computed using QGIS. All distance measures for the Integrated Values Surveys are saved in
\texttt{Paper2_Final\IVS_distances}.

4) Geolocation of the Berezkin Folklore Catalogue

To produce the geolocations used for the Berezkin Folklore Catalogue, the following notebook is used:

- Notebook: ...\Paper2_Final\pre_industrial\Berezkin_Location_Distances_Controls.ipynb

5) Motif coding in the Folklore Catalogue

Motif extraction and GPT-based coding
- Notebook: ...\Paper2_Final\pre_industrial\motifs20012026.ipynb

6) Conflict exposure (control) for IVS respondents and the pre-industrial analysis (Folklore Catalogue)

To construct the conflict‐exposure control used in both the IVS analyses and the pre-industrial (Folklore Catalogue) analysis, I use the following notebook:

* **Notebook:** `...\Paper2_Final\conflict_choke_points_ports\CONFLICT.ipynb`

In this notebook, I produce several conflict-exposure measures at different units of analysis and time horizons:

**(i) Contemporary conflict exposure (IVS respondents).**
Using UCDP/PRIO georeferenced event data, I compute—at the individual respondent level—the **number of conflict events within a 100-km radius** of each respondent’s **contemporary location**, matched to the respondent’s **survey year**. This yields a respondent-level conflict-exposure control (and its log transform) that varies by respondent location and survey year.

**(ii) Historical conflict exposure (ethnolinguistic homelands for IVS).**
Using HCED (historical conflict events), I compute—for each IVS ethnolinguistic homeland location—the **number of historical conflict records within 100 km** over the pre-specified historical periods (e.g., **1000–1500**, **1501–1800**, **1801–1989**). I then aggregate these measures to the ethnolinguistic group level (e.g., by `language_spkn_home`) and construct log-transformed versions.

**(iii) Historical conflict exposure (Berezkin/Folklore Catalogue groups).**
Using the same HCED historical conflict data and the same 100-km radius rule, I compute conflict exposure for **Berezkin ethnolinguistic locations** over the relevant historical periods used in the Folklore Catalogue analysis, again producing both levels and log transforms.

**(iv) Country-level conflict counts by period (for chokepoint–conflict regressions).**
To study the relationship between chokepoint proximity and conflict incidence, I construct **country-level conflict measures by period** by spatially assigning conflict events to **country polygons** (Natural Earth admin-0 shapefile) and counting conflicts within the target periods.

**(v) Geographic controls from Nunn & Puga (2012) (country level).**
For the chokepoint–conflict regressions, I assemble a country-level dataset that combines conflict outcomes with standard geographic covariates drawn from ** Nunn & Puga (2012)’s publicly available ruggedness dataset**. The main controls include:

* **Ruggedness** (terrain ruggedness index / ruggedness measure as provided in the Nunn–Puga data)
* **Distance to coast** (country-level distance-to-coast measure provided in the same source)
* **Latitude** (converted to **absolute latitude** for use as a standard geography control)
* **Soil / land productivity** (the “soil” variable in the Nunn–Puga file; used as a baseline land-quality/productivity control)
* **Continent indicators** (Africa/Europe/Asia dummies used as continent fixed effects)

Conflict analysis is implemented in:

* Do-file: `...\Paper2_Final\conflict_choke_points_ports\Conflict_Analysis.do`

## Datasets used
### Country-level analysis
* Main regression-ready dataset:
  `...\Paper2_Final\conflict_choke_points_ports\coutnry_conflcit_regready.dta`
  (Country-level conflict outcomes merged with distance-to-chokepoints measures and geographic controls.)

### Pre-industrial analysis

* Regression dataset (analysis-ready):
  `...\Paper2_Final\pre_industrial\berezkin_regression.dta`
* Distance measures (e.g., distance to choke points/ports):
  `...\Paper2_Final\pre_industrial\berezkin_distances.dta`
* Control variables (geographic and other controls):
  `...\Paper2_Final\pre_industrial\berezkin_control.dta`
* Conflict exposure measures constructed for Berezkin locations:
  `...\Paper2_Final\conflict_choke_points_ports\berezkin_conflict.dta`


7) Integrated Values Surveys Cleaning
"...\Paper2_Final\IVS_cleaning\korkut_IVS_Nature1cleaning.do"

