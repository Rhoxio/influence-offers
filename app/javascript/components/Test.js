import React from "react"
import PropTypes from "prop-types"

const Test = (props) => {
  return (
    <React.Fragment>
      Greeting: {props.greeting}
    </React.Fragment>
  )
}

Test.propTypes = {
  greeting: PropTypes.string
};

export default Test