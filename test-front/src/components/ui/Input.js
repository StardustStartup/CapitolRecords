import styled from 'styled-components';
import { TextInput } from 'react-native';

import { colors } from './variables';

export default styled(TextInput)`
  background-color: ${colors.snow};
  border: none;
  border-radius: 4px;
  color: ${colors.black};
  padding: 8px 12px;
`;
