import PropTypes from 'prop-types';
import React, { useState } from 'react';

const DiscoverForm = (props) => {
  return(
    <form className="discover-form">
      <label htmlFor="discover_form">Search</label>
      <input type="text" id="discover_form"/>
    </form>
  )
}

export default DiscoverForm;