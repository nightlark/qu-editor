meta:
  id: qu_scene
  application: QU Mixers
  endian: le
  encoding: utf-8
  file-extension: dat

seq:
  - id: unk1
    type: header
  - id: chan
    type: channel_entry
    repeat: expr
    repeat-expr: 60
  - id: unk2
    size: 14315
  - id: crc
    type: u4


types:
  header:
    seq:
      - id: unk1
        size: 12
      - id: name
        type: str
        size: 13
      - id: unk2
        size: 24
        
        
  channel_entry:
    seq:
      - id: peq
        type: peq
      - id: unk1
        size: 1
      - id: comp
        type: compressor
      - id: gate
        type: gate
      - id: unk2
        size: 65
      - id: hpf
        type: hpf
      - id: unk3
        size: 1
      - id: delay
        type: delay
      - id: unk4
        size: 1
      - id: fader
        type: u2
      - id: gain
        type: u2
      - id: trim
        type: u2
      - id: qu_drive_on_off
        type: u1
      - id: phantom_on_off
        type: u1
      - id: phase_flip_on_off
        type: u1
      - id: unk5
        size: 1
      - id: mute_on_off
        type: u1
      - id: fx_insert_on_off
        type: u1
      - id: unk6
        size: 1
      - id: d_snake_on_off
        type: u1
      - id: unk7
        size: 4
      - id: linked
        type: u1
      - id: unk8
        size: 3
      - id: preamp_linked
        type: u1
      - id: dynamicssidechain_pan_fader_mute_linked
        type: u1
      - id: unk9
        size: 3
      - id: d_snake_gain
        type: u1
      - id: unk10
        size: 1
      - id: pad_20db_on_off
        type: u1
      - id: name
        type: str
        size: 6
      - id: unk11
        size: 6
      - id: ducker
        type: ducker
      - id: number
        type: u1
      - id: unk12
        size: 9
        
    types:
      delay:
        seq:
          - id: time
            type: u2
          - id: on_off
            type: u1
            
      hpf:
        seq:
          - id: frequency
            type: u2
          - id: in_out
            type: u1
            
      peq:
        seq:
          - id: lf
            type: peq_setting
          - id: unk1
            size: 2
          - id: lm
            type: peq_setting
          - id: unk2
            size: 2
          - id: hm
            type: peq_setting
          - id: unk3
            size: 2
          - id: hf
            type: peq_setting
          - id: unk4
            size: 1
          - id: lf_shelf
            type: u1
          - id: hf_shelf
            type: u1
          - id: in_out
            type: u1
          
      peq_setting:
        seq:
          - id: gain
            type: u1
          - id: frequency
            type: u2
          - id: width
            type: u1
            
      compressor:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: knee
            type: u1
          - id: unk1
            size: 1
          - id: ratio
            type: u1
          - id: unk2
            size: 2
          - id: threshold
            type: u1
          - id: unk3
            size: 1
          - id: gain
            type: u1
          - id: type
            type: u1
          - id: in_out
            type: u1
            
      gate:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: unk1
            size: 1
          - id: threshold
            type: u1
          - id: unk2
            size: 1
          - id: depth
            type: u1
          - id: in_out
            type: u1
            
      ducker:
        seq:
          - id: attack
            type: u2
          - id: release
            type: u2
          - id: hold
            type: u2
          - id: unk1
            size: 1
          - id: threshold
            type: u1
          - id: unk2
            size: 2
          - id: on_off
            type: u1
          - id: trigger_input
            type: u1
          - id: single_gang
            type: u1
          - id: unk3
            size: 1
          - id: insert
            type: u1