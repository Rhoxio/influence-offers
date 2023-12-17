import ReactOnRails from 'react-on-rails';

import Discover from '../bundles/Discover/components/Discover';
import Offer from '../bundles/Discover/components/Offer';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Discover,
  Offer
});