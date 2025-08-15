## [1.11.2](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.11.1...v1.11.2) (2025-08-15)


### Bug Fixes

* add variables at control scope ([#56](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/56)) ([eba6167](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/eba61674e5ca4d364bbb0741eedac3514c3861de))

## [1.11.1](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.11.0...v1.11.1) (2025-08-14)


### Bug Fixes

* remove deprecated backend configuration ([#55](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/55)) ([72f4747](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/72f4747b790aa722588b063a38b5ccd9dd78899b))

# [1.11.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.10.0...v1.11.0) (2025-08-14)


### Bug Fixes

* cd pipeline conditional for matrix.workspace ([#52](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/52)) ([69ff827](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/69ff827e234e475e8883fe9005804e91dbb29b05))
* cd pipeline syntax error ([#53](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/53)) ([9d162a8](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/9d162a8f92567170b22d474a4042846b55ccdaaa))


### Features

* add dynamic aws accounts for mock route-to-live ([#51](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/51)) ([d3aa816](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/d3aa816af5ecf8810e18be7fde3926d508767174))

# [1.10.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.9.0...v1.10.0) (2025-08-13)


### Features

* add api authentication settings, KMS for bucket encryption and trace settings to lambda function ([#50](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/50)) ([1cd0c22](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/1cd0c22b1ddacee19befa4a8ca017cfdcbe41148))

# [1.9.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.8.0...v1.9.0) (2025-08-11)


### Bug Fixes

* CI/CD ordering and keep infrastructure alive ([#48](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/48)) ([304003f](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/304003fda91afe54072d6ebe3e4489c96f64d4f4))
* quick fix for log bucket variable ([#49](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/49)) ([c884992](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/c88499264a8f1714295ae95ad6c77aaa6b921507))


### Features

* add timeout option to lambda functions ([27f0946](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/27f0946008fe432e903aeb799058c4a478e4b906))

# [1.8.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.7.0...v1.8.0) (2025-08-11)


### Bug Fixes

* /download resource to download object from the S3 bucket using the API gateway ([#46](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/46)) ([5b200f2](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/5b200f206baae2b770a6e611c1dcb26341171313))
* align ([2800ac3](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/2800ac3c39cb58eeccf61a8194c7be897469f118))
* align naming conventions for lambda  ([#39](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/39)) ([841b858](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/841b858c2ab4548e1f16be1fe2268bdc18fa0623))
* binary types allowed on requests ([#45](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/45)) ([28698e4](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/28698e4ad6dcb70ec1ff5a46e8c037edef728673))
* bucket name environment variable ([#42](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/42)) ([003add1](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/003add1c928e8b304daacf5cce432ced774fae2d))
* revert ci cd destroy ([744178d](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/744178d7f46c145462acd68207108634cd1c376a))
* tagging ([#41](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/41)) ([2676522](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/26765227989a61ecfdfd090d049a5b448e0699a0))
* typo ([ba075cc](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/ba075cc259d858b9991b6c93925780443323ff8d))


### Features

* add api call verbosity ([#40](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/40)) ([6974730](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/69747302db0c63a171556c9251f42cb78a340eae))
* add apply branch pipeline functionality ([700dce3](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/700dce3289423491c99bbd0a0f7431887181df60))
* add dynamo db integration ([#43](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/43)) ([c66fa15](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/c66fa15018d452d25f5369f30a98747a9a47a7e2))

# [1.7.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.6.0...v1.7.0) (2025-08-09)


### Features

* add destroy branch ([#38](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/38)) ([6ca4f4d](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/6ca4f4dc73832b0b77836af760926fd4bcc5ec50))

# [1.6.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.5.1...v1.6.0) (2025-08-09)


### Bug Fixes

* remove unnecessary IAM association ([a4105d1](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/a4105d11196cdbcdb203c5c002b8688906b499cd))


### Features

* make main.tf leaner removing unrequired resources ([#37](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/37)) ([3186cc4](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/3186cc47ab4ed1d1a9706a0083b3659e6db68d2c))

## [1.5.1](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.5.0...v1.5.1) (2025-08-08)


### Bug Fixes

* CI and CD workflow split ([#36](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/36)) ([95a11a7](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/95a11a705e55eb8f58ffa0716d29d3370b860ab9))
* dynamo db provisioning ([#35](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/35)) ([971a939](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/971a93909949b5fdc630fcb5bad3718be9b6e2ff))

# [1.5.0](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/compare/v1.4.0...v1.5.0) (2025-08-08)


### Bug Fixes

* correct tfstate bucket configuration once more ([bf03b34](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/bf03b34209f47bea7f5276e604890c6963e70449))
* make technical task and generic repository now ([4d33b6d](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/4d33b6d279c974774acab58ffc1d7f7542865e5d))
* set defaults for module names ([#32](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/32)) ([03ea104](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/03ea104978de016d6352226e7a60f0727bc81c78))
* tfstate bucket implementation ([3625a96](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/3625a968b621e89585a9fcce739b59f5be9d7e7a))
* tfstate bucket implementation ([684e340](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/684e3403789849c5e50b109fccb8355c786f0f95))


### Features

* add capability of multiple resources on single API gateway ([#34](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/issues/34)) ([4d3e16b](https://github.com/GrabAByte/terraform-control-aws-api-gateway-whitepaper/commit/4d3e16b1dc8c2073715aa176956a08c8b0e291e8))

## [1.4.1](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/compare/v1.4.0...v1.4.1) (2025-05-31)


### Bug Fixes

* correct tfstate bucket configuration once more ([bf03b34](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/commit/bf03b34209f47bea7f5276e604890c6963e70449))
* make technical task and generic repository now ([4d33b6d](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/commit/4d33b6d279c974774acab58ffc1d7f7542865e5d))
* set defaults for module names ([#32](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/issues/32)) ([03ea104](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/commit/03ea104978de016d6352226e7a60f0727bc81c78))
* tfstate bucket implementation ([3625a96](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/commit/3625a968b621e89585a9fcce739b59f5be9d7e7a))
* tfstate bucket implementation ([684e340](https://github.com/GrabAByte/terraform-control-aws-api-lambda-trigger-to-s3/commit/684e3403789849c5e50b109fccb8355c786f0f95))

# [1.4.0](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.3.0...v1.4.0) (2025-05-30)


### Features

* abandon module monorepo structure for decoupled module approach ([#31](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/31)) ([5961d5e](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/5961d5edbcf8449b0c53adb09d7d13c89eb253f3))

# [1.3.0](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.2.2...v1.3.0) (2025-05-27)


### Features

* Add smoke test for API ([#30](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/30)) ([044f1d5](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/044f1d56f926e2dc90c4b9c8fa1a1ab5a40315dd))

## [1.2.2](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.2.1...v1.2.2) (2025-05-26)


### Bug Fixes

* resolve api gateway deployment deprecated reference to stage_name [#29](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/29) ([5cc46ac](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/5cc46ac6b87a318a6889fa6f17957558e1fea290))

## [1.2.1](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.2.0...v1.2.1) (2025-05-26)


### Bug Fixes

* harden the bearer logic ([#28](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/28)) ([4622a35](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/4622a3593d24f2e1e3cde4d216cd8e74fd6c4c95))

# [1.2.0](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.1.0...v1.2.0) (2025-05-25)


### Features

* add annotations and final opportunities for security enhancement ([#27](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/27)) ([593159a](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/593159a0effe41a825347c3ce99feff998e52c93))

# [1.1.0](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.0.3...v1.1.0) (2025-05-24)


### Features

* add variables for module inputs ([#25](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/25)) ([5e06ad2](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/5e06ad2c5592888aedd30f8bf37375ac9560ac62))
* reintegrate extra configurations into working solution ([#24](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/24)) ([246d2a2](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/246d2a2763f425f86102c783849ae8555301885b))
* stripped back working solution ([#23](https://github.com/GrabAByte/terraform-aws-convertr-demo/issues/23)) ([9bca8f5](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/9bca8f55c894488f9b304d8c5c337635af9f2c9c))

## [1.0.3](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.0.2...v1.0.3) (2025-05-23)


### Bug Fixes

* terraform commands in README.md ([06a2ed2](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/06a2ed2e618bd700fd195c9c27af5ee1b476af83))

## [1.0.2](https://github.com/GrabAByte/terraform-aws-convertr-demo/compare/v1.0.1...v1.0.2) (2025-05-23)


### Bug Fixes

* semantic-release capability to update CHANGELOG.md ([2b6b1c0](https://github.com/GrabAByte/terraform-aws-convertr-demo/commit/2b6b1c04664d725717622da44595d7b8ef5cfc0b))

###########################################################################################################

### Custom Changelog generation stopped at 0.6.1 having been replaced at 1.0.0 by semantic-release, the changelog plugin was added for release 1.0.2 starting the new pattern above.

## [0.6.1] - (23-05-2025)
fix: (e098827) tidy up and variablize code (#18)

## [0.6.0] - (22-05-2025)
feat: (81a323f) Add README.md (#17)

## [0.5.0] - (22-05-2025)
feat: (5d40754) extra sec hardening (#16)

## [0.4.0] - (22-05-2025)
feat: (ebe8ed1) apply hardening configuation (#15)

## [0.3.2] - (22-05-2025)
fix: (60a6cb1) subtle uncleaniness in the code (#13)

## [0.3.1] - (22-05-2025)
chore: (a9a8be4) format terraform module code (#12)

## [0.3.0] - (22-05-2025)
feat: (b78b3d3) open additional attributes for achitecture (#10)

## [0.2.0] - (21-05-2025)
feat: (d52458f) Add terraform destroy and lambda ARN lookup (#9)

## [0.1.0] - (20-05-2025)
feat: (08b8c67) convert repository to implement terraform modules (#7)

## [0.0.1] - (20-05-2025)
fix: (432dc0c) metadata entry (#6)
