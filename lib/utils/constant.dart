import 'package:flutter/material.dart';

import '../widget/bottom_sheet.dart';
import '../widget/insurance_type_card.dart';

 List<InsuranceTypeCard> insuranceTypeList(BuildContext context) => [
  InsuranceTypeCard(
    onTap: () => carBottomSheet(context),
    logo: 'assets/images/jeep.png',
    type: 'Motor Insurance',
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/fire.png',
    type: 'Fire Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/life-vest.png',
    type: 'Life Assurance Policies',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/ship.png',
    type: 'Marine Cargo Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/home.png',
    type: 'Householder Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/burglar.png',
    type: 'Burglary Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/tablet.png',
    type: ' Gadget Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),
  InsuranceTypeCard(
    onTap: () {},
    logo: 'assets/images/travel.png',
    type: 'Travel Insurance',
    comingSoon: true,
    description:
        'At faucibus etiam vel lobortis enim fermentum a. At nec enim tellus senectus turpis auctor pretium non. ',
  ),];