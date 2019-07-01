import { css } from 'glamor';
import {
  $gray,
  $grayD,
  $white
} from '../../../variables';

export const cards = css({
  '> .card-item': {
    color: $gray,
    '> h3': {
      marginBottom: 30,
    },
    '> p': {
      lineHeight: '28px'
    }
  }
});
export const section = css ({
  position: 'relative',
  width: '100% !important',
  height: '40vh !important',
  minHeight: '500px !important',
  maxHeight: '900px !important',
  overflow: 'hidden !important',
  contain: 'strict !important',
  '> div > div > h1': {
    color: $white,
    fontSize: 72,
    textAlign: 'center',
    marginTop: '20vh'
  }
});
export const eyecatcherWrapper = css({
  width: '100vw !important',
  position: 'absolute !important',
  height: '40vh !important',
  minHeight: '500px !important',
  maxHeight: '900px !important',
  overflow: 'hidden !important',
  contain: 'strict !important',
  backgroundColor: $grayD,
  '> img.eyecatcher-word-issuer': {
    position: 'absolute',
    height: '100%',
    width: 'auto',
    zIndex: -1,
    opacity: .8
  }
})