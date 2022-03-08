<div id="top"></div>

<!-- PROJECT SHIELDS -->
<!--
TODO: Add shields related to testing, building, and so on.
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="images/pong.png" alt="Logo" width="250">
  </a>

<h3 align="center">Pong-Lua</h3>

  <p align="center">
    project_description
    <br />
    <a href="https://github.com/github_username/repo_name"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/github_username/repo_name">View Demo</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Report Bug</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

<!--
TODO: Add a screenshot

[![Product Name Screen Shot][product-screenshot]](https://example.com)
-->

Pong is a classic game that simulates table tennis, released for Atari in 1972. The game features two paddles, controlled by the players, which move vertically across the left and right sides of the screen. Additionally, the game features a ball, which travels across the screen, bouncing off the top and bottom edges and the paddles. Players must try to hit the ball with their paddles to prevent it from falling off the vertical edges of the screen. A player scores when the opposing player fails to catch the ball. The first player to score 11 points wins.

This project implements Pong with the Lua programming language, using the LÖVE2D framework. It is inspired by Harvard's University 2018 CDS0 course, taught by Colton Ogden. The lectures are available on this [Youtube playlist](https://www.youtube.com/playlist?list=PLWKjhJtqVAbluXJKKbCIb4xd7fcRkpzoz).

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

<table>
  <tr>
    <td>
        <img src="images/lua_logo.png" alt="Lua Logo" height="48">
    </td>
    <td>
        <a href="https://lua.org/" target = "_blank">Lua
        </a> a lightweight scripting language.
    </td>
  </tr>
  <tr>
    <td>
        <img src="images/love_logo.png" alt="Love2D Logo" height="48">
    </td>
    <td>
    <a href="https://love2d.org/" target = "_blank">LÖVE2D
    </a> a framework for 2D game development in Lua.
    </td>
  </tr>
 </table>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

The game runs on LÖVE2D. For details on how to install LÖVE2D for your specific platform, consult their [webpage](https://love2d.org).

<!--
* a prerequisite
  ```sh
  some shell script
  ```
TODO: possibly add instructions on installing lua
-->
<!--
TODO: Add installation instructions.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Marlon-Gomes/pong-lua.git
   ```
2. Do something else
   ```sh
   a fancy shell script
   ```

<p align="right">(<a href="#top">back to top</a>)</p>
-->


<!-- USAGE EXAMPLES
TODO: add usage
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#top">back to top</a>)</p>
-->


<!-- ROADMAP
TODO: add a roadmap
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/Marlon-Gomes/pong-lua/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>
-->


<!-- CONTRIBUTING -->
## Contributing

Any contributions you make are **greatly appreciated**.If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch by branching from develop (`git checkout -b feature/AmazingFeature develop`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Pong-lua is distributed under the MIT License. See `LICENSE.txt` for more information.

Pong-lua relies on source code and media files that are subject to licenses of their own. Please consult the third-party licenses [README.md][third-party-licenses-url] for a list containing links to individual licenses.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Marlon de Oliveira Gomes - 72144990+Marlon-Gomes@users.noreply.github.com

Project Link: [https://github.com/Marlon-Gomes/pong-lua](https://github.com/Marlon-Gomes/pong-lua)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* This code is based on [Colton Ogden](https://github.com/coltonoscopy)'s interpretation of the game. It was the subject of a lecture in his CS50 course at Harvard in 2018. The original repo can be found at https://github.com/games50/pong.
* Classes are not native to the Lua languange. The implementation of classes used here, <code>class.lua</code>, is part of the [hump][hump-docs] package, a suite of tools for game development in the LÖVE framework due to Matthias Richter.
* Sound effects were generated with [jsfxr](https://github.com/chr15m/jsfxr). Many thanks to the contributors of the project.
<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Marlon-Gomes/pong-lua.svg?style=for-the-badge
[contributors-url]: https://github.com/Marlon-Gomes/pong-lua/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Marlon-Gomes/pong-lua.svg?style=for-the-badge
[forks-url]: https://github.com/Marlon-Gomes/pong-lua/network/members
[stars-shield]: https://img.shields.io/github/stars/Marlon-Gomes/pong-lua.svg?style=for-the-badge
[stars-url]: https://github.com/Marlon-Gomes/pong-lua/stargazers
[issues-shield]: https://img.shields.io/github/issues/Marlon-Gomes/pong-lua.svg?style=for-the-badge
[issues-url]: https://github.com/Marlon-Gomes/pong-lua/issues
[license-shield]: https://img.shields.io/github/license/Marlon-Gomes/pong-lua.svg?style=for-the-badge
[license-url]: https://github.com/Marlon-Gomes/pong-lua/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/marlon-deoliveiragomes
[product-screenshot]: images/screenshot.pngA
[hump-docs]: https://hump.readthedocs.io/en/latest/#
[love-logo]: images/love_logo.png
[lua-logo]: images/lua_logo.png
[third-party-licenses-url]: THIRD_PARTY_LICENSES/README.md
